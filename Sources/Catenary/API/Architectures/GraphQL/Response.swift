// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL {
	struct Response<Fields: Decodable> {
		private let container: KeyedDecodingContainer<CodingKeys>
	}
}

// MARK: -
public extension GraphQL.Response {
	func resource<Resource: Decodable>() throws -> Resource {
		try container.decode(Resource.self, forKey: .data)
	}
}

// MARK: -
extension GraphQL.Response: Decodable {
	// MARK: Decodable
	public init(from decoder: any Decoder) throws {
		container = try decoder.container(keyedBy: CodingKeys.self)
	}
}

// MARK: -
private extension GraphQL.Response {
	enum CodingKeys: String, CodingKey {
		case data
		case errors
		case extensions
	}
}
