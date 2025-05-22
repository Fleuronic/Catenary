// Copyright © Fleuronic LLC. All rights reserved.

public struct Response<Fields: Decodable> {
	private let container: KeyedDecodingContainer<CodingKeys>
}

// MARK: -
public extension Response {
	var fields: [Fields] {
		get throws {
			try container.decode(Data.self, forKey: .data).fields
		}
	}
}

// MARK: -
extension Response: Decodable {
	// MARK: Decodable
	public init(from decoder: any Decoder) throws {
		container = try decoder.container(keyedBy: CodingKeys.self)
	}
}

// MARK: -
private extension Response {
	enum CodingKeys: String, CodingKey {
		case data
		case errors
		case extensions
	}
}
