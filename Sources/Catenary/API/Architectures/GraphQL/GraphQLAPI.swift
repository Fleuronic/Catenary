// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.Data
import struct Foundation.URLRequest
import struct PersistDB.Predicate
import class Foundation.NSError
import class Foundation.URLSession
import class Foundation.JSONEncoder
import protocol Catena.Fields

public protocol GraphQLAPI: API where Response == GraphQL.Response, Error == GraphQL.Error.List {
	func queryString<Fields: Catena.Fields>(for query: GraphQL.Query<Fields>) -> String
}

// MARK: -
public extension GraphQLAPI {
	func query<Fields: Catena.Fields & Decodable>(_ query: GraphQL.Query<Fields>) async -> Result<[Fields]> {
		do {
			let encoder = JSONEncoder()
			let body = GraphQL.Query<Fields>.Body(queryString: queryString(for: query))
			var urlRequest = URLRequest(url: baseURL)
			urlRequest.httpMethod = "POST"
			urlRequest.addValue("N32FEDGy6CEmYyIQQqNOV8Ch54TqEsIYZy7hu4MHUsMbZYnrb5dh8mbyBYaeV2qx", forHTTPHeaderField: "x-hasura-admin-secret")
			urlRequest.httpBody = try encoder.encode(body)

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

	func query<Fields: Catena.Fields & Decodable>(where predicate: Predicate<Fields.Model>) async -> Result<[Fields]> {
		await query(.query(Fields.Model.all.filter(predicate)))
	}
}

// MARK: -
private extension GraphQLAPI {
	func resource<Fields: Decodable>(from data: Data) throws -> [Fields] {
		do {
			let resource: GraphQL.Response.Data<Fields> = try decoder.decode(Response.self, from: data).resource()
			return resource.fields
		} catch {
			throw try decoder.decode(Error.self, from: data)
		}
	}
}
