// Copyright © Fleuronic LLC. All rights reserved.

extension Response {
	struct Data {
		let fields: [Fields]
	}
}

// MARK: -
extension Response.Data: Decodable {
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: Key.self)
		let key = container.allKeys.first!
		fields = try container.decode([Fields].self, forKey: key)
	}
}
