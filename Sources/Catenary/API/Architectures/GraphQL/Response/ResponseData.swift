// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Model

public extension GraphQL.Response {
	struct Data<Fields: Decodable> {
		let fields: [Fields]
	}
}

// MARK: -
extension GraphQL.Response.Data: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: DynamicKey.self)
		let key = container.allKeys.first!

		if let fields = try? container.decode(Fields.self, forKey: key) {
			self.fields = [fields]
		} else if let fields = try? container.decode([Fields].self, forKey: key) {
			self.fields = fields
		} else {
			let data = try container.decode(Self.self, forKey: key)
			fields = data.fields
		}
	}
}
