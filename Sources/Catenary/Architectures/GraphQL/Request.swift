// Copyright © Fleuronic LLC. All rights reserved.

public enum GraphQL {}

// MARK: -
public extension GraphQL {
	enum Request {}
}

// MARK: -
public extension GraphQL.Request {
	struct Error: Swift.Error, Equatable {}
}
