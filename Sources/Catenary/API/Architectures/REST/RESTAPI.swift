// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.Data
import class Foundation.URLSession
import class Foundation.NSError

public protocol RESTAPI: API {}

// MARK: -
public extension RESTAPI {
	func getResource<Resource: Decodable>(at path: String) async -> Result<Resource> {
		await resource(path: path, method: "GET")
	}

	func resource<Resource: Decodable>(path: String, method: String) async -> Result<Resource> {
		do {
			let url = URL(string: "\(baseURL.absoluteString)\(path)")!
			var urlRequest = URLRequest(url: url)
			urlRequest.httpMethod = method

			if let resource: Result<Resource> = try await mockResource(path: path, method: method) {
				return resource
			}

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

	func resource<Resource: Decodable>(from data: Data) throws -> Resource {
		do {
			return try decoder.decode(Response.self, from: data).resource()
		} catch is DecodingError {
			throw try decoder.decode(Error.self, from: data)
		}
	}
}
