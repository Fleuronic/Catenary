// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public struct Query {
	private let body: String
}

// MARK: -
public extension Query {
	init(
		name: String,
		fieldNames: [String]
	) {
		body = Weave(.query) {
			Object(name) {
				ForEachWeavable(fieldNames, content: Field.init)
			}
		}.description
	}
}

// MARK: -
extension Query: Encodable {
	// MARK: Encodable
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(body)
	}
}
