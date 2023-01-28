// Copyright © Fleuronic LLC. All rights reserved.

import Catena
import Schemata
import PersistDB

public extension GraphQL.Query {
	enum Mutation {
		case insert([Fields.Model], many: Bool = false)
		case update(Predicate<Fields.Model>?, ValueSet<Fields.Model>, byPrimaryKey: Bool = false)
		case delete(Predicate<Fields.Model>?, byPrimaryKey: Bool = false)
	}
}

// MARK: -
extension GraphQL.Query.Mutation: CustomStringConvertible {
	public var description: String {
		switch self {
		case .insert:
			return "insert"
		case .update:
			return "update"
		case .delete:
			return "delete"
		}
	}
}
