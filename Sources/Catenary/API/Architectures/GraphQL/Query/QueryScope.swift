// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL.Query {
	enum Scope {
		case single
		case many(options: GraphQL.Connection.Options = [])
	}
}

extension GraphQL.Query.Scope {
	var queryName: String {
		switch self {
		case .single:
			Fields.Model.schema.name
		case .many:
			Fields.Model.schema.name
		}
	}
}
