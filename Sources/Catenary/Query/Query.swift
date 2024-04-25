// Copyright © Fleuronic LLC. All rights reserved.

import struct Schemata.None
import struct PersistDB.Query

import enum Catena.GraphQL

public extension GraphQL {
	enum Query<Fields: Catenary.Fields> {
		case query(PersistDB.Query<None, Fields.Model>, scope: Scope = .many())
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
