// Copyright © Fleuronic LLC. All rights reserved.

public extension GraphQL {
	struct Response {
		private let container: KeyedDecodingContainer<CodingKeys>
	}
}

// MARK: -
extension GraphQL.Response: APIResponse {
	public func resource<Resource: Decodable>() throws -> Resource {
		try container.decode(Resource.self, forKey: .data)
	}

	// MARK: Decodable
	public init(from decoder: Decoder) throws {
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
