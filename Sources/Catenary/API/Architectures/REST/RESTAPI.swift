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
	func getResource<Resource: Decodable>(at path: String) async -> Result<Resource> {
		await resource(
			path: path,
			method: "GET"
		)
	}

	func post<Resource: Decodable>(_ data: Data, to path: String) async -> Result<Resource> {
		await resource(
			path: path,
			method: "POST",
			body: data
		)
	}

	func postResource<Resource: Decodable, PostedResource: Encodable>(_ postedResource: PostedResource, to path: String) async -> Result<Resource> {
		await resource(
			path: path,
			method: "POST",
			body: try! encoder.encode(postedResource)
		)
	}

	func deleteResource(at path: String) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "DELETE"
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
	func resource<Resource: Decodable>(
		path: String,
		method: String,
		body: Data? = nil
	) async -> Result<Resource> {
		do {
			if let resource: Result<Resource> = try await mockResource(path: path, method: method) {
				return resource
			}

			let url = url(for: path)
			let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//			components.queryItems = [.init(name: "url", value: "https://www.apple.com")]

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

