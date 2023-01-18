// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL.Error {
	struct List {
		public let errors: [GraphQL.Error]
	}
}

// MARK: -
extension GraphQL.Error.List: APIError {
	public var message: String {
		errors
			.map(\.message)
			.joined(separator: " ")
	}
}
