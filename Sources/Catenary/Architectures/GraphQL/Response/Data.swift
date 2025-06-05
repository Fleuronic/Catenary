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
			fields = try container.decode(for: key)
		} catch {
			let nestedContainer = try container.nestedContainer(keyedBy: Key.self, forKey: key)
			let nestedKey = nestedContainer.allKeys.first!
			fields = try nestedContainer.decode(for: nestedKey)
		}
	}
}
