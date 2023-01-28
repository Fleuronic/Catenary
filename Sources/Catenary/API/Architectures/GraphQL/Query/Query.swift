// Copyright © Fleuronic LLC. All rights reserved.

import struct Schemata.None
import struct PersistDB.Query
import protocol PersistDB.ModelProjection
import protocol Catena.Fields

public extension GraphQL {
	enum Query<Fields: ModelProjection> {
		case query(PersistDB.Query<None, Fields.Model>)
		case mutation(Mutation)
	}
}

// MARK: -
extension GraphQL.Query: CustomStringConvertible {
	public var description: String {
		switch self {
		case .query:
			return "query"
		case .mutation:
			return "mutation"
		}
	}
}
