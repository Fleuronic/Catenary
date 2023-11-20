// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

import protocol Catena.Fields

public extension GraphQL {
	enum Query<Fields: Catena.Fields> {
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
