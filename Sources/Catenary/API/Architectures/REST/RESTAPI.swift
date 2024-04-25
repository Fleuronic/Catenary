// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.Data
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.URLComponents
import class Foundation.URLSession
import class Foundation.NSError
import class Foundation.HTTPURLResponse

public protocol RESTAPI: API {}

// MARK: -
public extension RESTAPI {
	func getResource(at path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "GET",
			parameters: parameters
		)

		return result.map { _ in }
	}

	func getResource<Resource: Decodable>(at path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await resource(
			path: path,
			method: "GET",
			parameters: parameters
		)
	}

	func post(_ payload: some Payload, to path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await self.resource(
			path: path,
			method: "POST",
			parameters: parameters,
			body: payload.data(using: encoder)
		)

		return result.map { _ in }
	}

	func post<Resource: Decodable>(_ payload: some Payload, to path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await self.resource(
			path: path,
			method: "POST",
			parameters: parameters,
			body: payload.data(using: encoder)
		)
	}

	func put(_ payload: some Payload = EmptyPayload(), at path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		// TODO
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "PUT",
			parameters: parameters,
			body: payload.data(using: encoder)
		)

		return result.map { _ in }
	}

	func put<Resource: Decodable>(_ payload: some Payload = EmptyPayload(), at path: String, with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await resource(
			path: path,
			method: "PUT",
			parameters: parameters,
			body: payload.data(using: encoder)
		)
	}

	func deleteResource(at path: String, using payload: some Payload = EmptyPayload(), with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: "DELETE",
			parameters: parameters,
			body: payload.data(using: encoder)
		)

		return result.map { _ in }
	}
}

// MARK: -
extension RESTAPI {
	func resource<Resource: Decodable>(
		data: Data,
		response: HTTPURLResponse?
	) throws -> Resource {
		try
			response?.url as? Resource ??
			data as? Resource ??
			decoder.decode(Response.self, from: data).resource()
	}
}

// MARK: -
private extension RESTAPI {
	func resource<Resource: Decodable>(
		path: String,
		method: String,
		parameters: some Parameters,
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

			if body != nil {
				urlRequest.apply(.jsonContentType)
			}

			let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
			return try .success(
				resource(
					data: data,
					response: urlResponse as? HTTPURLResponse
				)
			)
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

