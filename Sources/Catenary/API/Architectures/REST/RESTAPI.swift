// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.Data
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.URLComponents
import class Foundation.URLSession
import class Foundation.NSError

public protocol RESTAPI: API {}

// MARK: -
public extension RESTAPI {
	func getResource<Resource: Decodable, QueryParameters: Parameters>(at path: String, with parameters: QueryParameters = EmptyParameters()) async -> Result<Resource> {
		await resource(
			path: path,
			method: "GET",
			parameters: parameters
		)
	}

	func post<Resource: Encodable, ReturnedResource: Decodable, QueryParameters: Parameters>(_ resource: Resource, to path: String, with parameters: QueryParameters = EmptyParameters()) async -> Result<ReturnedResource> {
		await self.resource(
			path: path,
			method: "POST",
			parameters: parameters,
			body: try! encoder.encode(resource)
		)
	}

	func put<QueryParameters: Parameters>(at path: String, with parameters: QueryParameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "PUT",
			parameters: parameters
		)

		return result.map { _ in }
	}


	func put<ReturnedResource: Decodable, QueryParameters: Parameters>(at path: String, with parameters: QueryParameters = EmptyParameters()) async -> Result<ReturnedResource> {
		await resource(
			path: path,
			method: "PUT",
			parameters: parameters
		)
	}

	func deleteResource<QueryParameters: Parameters>(at path: String, with parameters: QueryParameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "DELETE",
			parameters: parameters
		)

		return result.map { _ in }
	}
}

// MARK: -
extension RESTAPI {
	func resource<Resource: Decodable>(from data: Data) throws -> Resource {
		try data as? Resource ?? decoder.decode(Response.self, from: data).resource()
	}
}

// MARK: -
private extension RESTAPI {
	func resource<Resource: Decodable, QueryParameters: Parameters>(
		path: String,
		method: String,
		parameters: QueryParameters,
		body: Data? = nil
	) async -> Result<Resource> {
		do {
			if let resource: Result<Resource> = try await mockResource(path: path, method: method) {
				return resource
			}

			let url = url(for: path)
			var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
			let queryItems = try parameters.queryItems
			if !queryItems.isEmpty {
				components.queryItems = queryItems
			}

			var urlRequest = URLRequest(url: components.url!)
			urlRequest.httpMethod = method
			urlRequest.httpBody = body
			authenticationHeader.map { urlRequest.apply($0) }

			let (data, _) = try await URLSession.shared.data(for: urlRequest)
			return try .success(resource(from: data))
		} catch let error as Error {
			return .failure(.api(error))
		} catch let error as DecodingError {
			return .failure(.decoding(error))
		} catch let error as NSError {
			return .failure(.network(error))
		}
	}
}

private struct EmptyResource: Decodable {}

