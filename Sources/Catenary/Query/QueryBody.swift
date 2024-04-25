// Copyright © Fleuronic LLC. All rights reserved.

import enum Catena.GraphQL

extension GraphQL.Query {
	struct Body {
		let queryString: String
	}
}

// MARK: -
extension GraphQL.Query.Body: Encodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case queryString = "query"
	}
}
