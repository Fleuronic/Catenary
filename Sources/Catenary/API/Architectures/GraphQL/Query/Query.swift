// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB
import Catena

public extension GraphQL {
	enum Query<Fields: PersistDB.ModelProjection> {
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
