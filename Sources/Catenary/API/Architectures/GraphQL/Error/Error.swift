// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL {
	struct Error {
		public let message: String
	}
}

// MARK: -
extension GraphQL.Error: APIError {}
