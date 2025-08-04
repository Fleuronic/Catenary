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

		do {
			let fields = try? container.decode(Fields.self, forKey: key)
			try self.fields = fields.map { [$0] } ?? container.decode([Fields].self, forKey: key)
		} catch {
			let nestedContainer = try container.nestedContainer(keyedBy: Key.self, forKey: key)
			let nestedKey = nestedContainer.allKeys.first!
			fields = nestedContainer.decode(for: nestedKey)
		}
	}
}
