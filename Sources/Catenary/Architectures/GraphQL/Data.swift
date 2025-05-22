// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL.Response {
	struct Data: Decodable {
		public let fields: Fields
	}
}
