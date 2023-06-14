// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Schemata
import PersistDB
import Catena

public protocol GraphQLAPI: API where Response == GraphQL.Response, Error == GraphQL.Error.List {
	func queryString<Fields: Catena.Fields>(for query: GraphQL.Query<Fields>) -> String
}

// MARK: -
public extension GraphQLAPI {
	func send<Fields: Catena.Fields>(_ query: PersistDB.Query<None, Fields.Model>) async -> Result<[Fields]> {
		await self.query(.query(query))
	}

	func send<Fields: Catena.Fields>(_ mutation: GraphQL.Query<Fields>.Mutation) async -> Result<[Fields]> {
		await query(.mutation(mutation))
	}
}

// MARK: -
private extension GraphQLAPI {
	func query<Fields: Catena.Fields>(_ query: GraphQL.Query<Fields>) async -> Result<[Fields]> {
		do {
			let encoder = JSONEncoder()
			let body = GraphQL.Query<Fields>.Body(queryString: queryString(for: query))
			var urlRequest = URLRequest(url: baseURL)
			urlRequest.httpMethod = "POST"
			urlRequest.addValue("B7yNhxTpV5iNSGQQeZ3c26wPqPo6lyqSbPoYD41U5UEuhHMuEidpaZ3AkBLIG8xm", forHTTPHeaderField: "x-hasura-admin-secret")
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

	func resource<Fields: Decodable>(from data: Data) throws -> [Fields] {
		do {
			let resource: GraphQL.Response.Data<Fields> = try decoder.decode(Response.self, from: data).resource()
			return resource.fields
		} catch {
			throw try decoder.decode(Error.self, from: data)
		}
	}
}
