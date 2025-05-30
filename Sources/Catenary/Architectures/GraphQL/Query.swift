// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public struct Query {
	private let body: String
}

// MARK: -
public extension Query {
	init(
		name: String,
		paths: [[String]]
	) {
		body = Weave(.query) {
			Object(name) {
				ForEachWeavable(paths, content: \.content)
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

// MARK:
private extension [String] {
	var content: any ObjectWeavable {
		let head = self[0]
		let tail = Array(self[1...])
		return (count == 1) ? Field(head) : Object(head) {
			tail.content
		}
	}
}
