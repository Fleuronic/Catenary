// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB
import SociableWeaver

import struct Foundation.Data
import struct Foundation.URLRequest
import class Foundation.NSError
import class Foundation.URLSession
import class Foundation.JSONEncoder
import protocol Catena.Fields

public protocol GraphQLAPI: API where Response == GraphQL.Response, Error == GraphQL.Error.List {
	var connectionOptions: GraphQL.Connection.Options { get }

	func queryString<Fields: Catena.Fields>(for query: GraphQL.Query<Fields>) -> String
}

// MARK: -
public extension GraphQLAPI {
	func query<Fields: Catena.Fields>(id: Fields.Model.ID, returning fields: Fields.Type) async -> Result<Fields?> {
		let query = Fields.Model.all.filter(Fields.Model.idKeyPath == id)
		return await self.query(.query(query, scope: .single)).map(\.first)
	}

	func query<Fields: Catena.Fields>(where predicate: Expression<Fields.Model, Bool>? = nil, returning fields: Fields.Type) async -> Result<[Fields]> {
		let query = predicate.map { Fields.Model.all.filter($0) } ?? Fields.Model.all
		return await self.query(.query(query, scope: .many(options: connectionOptions)))
	}

	func send<Fields: Catena.Fields>(_ query: PersistDB.Query<None, Fields.Model>) async -> Result<[Fields]> {
		await self.query(.query(query))
	}

	func send<Fields: Catena.Fields>(_ mutation: GraphQL.Query<Fields>.Mutation) async -> Result<[Fields]> {
		await query(.mutation(mutation))
	}

	// MARK: GraphQLAPI
	var connectionOptions: GraphQL.Connection.Options { [] }

	func queryString<Fields: Catena.Fields>(for query: GraphQL.Query<Fields>) -> String {
		switch query {
		case let .query(query, scope):
			let arguments = arguments(for: query)
			return Weave(.query) {
				arguments.reduce(object(in: scope)) {
					$0.argument(key: $1.0, value: $1.1)
				}
			}.description
		case .mutation:
			return ""
		}
	}
}

// MARK: -
private extension GraphQLAPI {
	func query<Fields: Catena.Fields>(_ query: GraphQL.Query<Fields>) async -> Result<[Fields]> {
		do {
			var urlRequest = URLRequest(url: url(forPath: "graphql"))
			let body = GraphQL.Query<Fields>.Body(queryString: queryString(for: query))

			urlRequest.httpMethod = "POST"
			urlRequest.httpBody = try encoder.encode(body)
			urlRequest.apply(.jsonContentType)
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

	func resource<Fields: Decodable>(from data: Data) throws -> [Fields] {
		do {
			let resource: GraphQL.Response.Data<Fields> = try decoder.decode(Response.self, from: data).resource()
			return resource.fields
		} catch {
			throw try decoder.decode(Error.self, from: data)
		}
	}

	func object<Fields: Catena.Fields>(in scope: GraphQL.Query<Fields>.Scope) -> Object {
		let fields = ForEachWeavable(
			Fields.projection
				.keyPaths
				.map(Fields.Model.schema.properties)
				.flatMap { $0.map(\.path) },
			content: Field.init
		)

		return .init(scope.queryName) {
			switch scope {
			case let .many(options) where options.contains(.nodes):
				Object(GraphQL.Connection.Options.nodes.field) { fields }
			default:
				fields
			}
		}
	}

	func arguments<Model>(for query: PersistDB.Query<None, Model>) -> [(String, ArgumentValueRepresentable)] {
		query.predicates
			.flatMap(\.dictionary)
			.compactMap { key, value in
				guard
					let value = value as? [String: Any],
					let value = value["=="] as? ArgumentValueRepresentable else { return nil }
				return (key, value)
			}
	}
}
