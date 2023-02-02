// Copyright © Fleuronic LLC. All rights reserved.

import Catena
import Schemata
import PersistDB

public extension GraphQL.Query {
	enum Mutation {
		case insert([Fields.Model], many: Bool = false)
		case update(Selector, ValueSet<Fields.Model>)
		case delete(Selector)
	}
}

// MARK: -
public extension GraphQL.Query.Mutation {
	enum Selector {
		case all
		case primaryKey(Fields.Model.ID)
		case predicate(Predicate<Fields.Model>)
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
