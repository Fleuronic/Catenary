// Copyright © Fleuronic LLC. All rights reserved.

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
