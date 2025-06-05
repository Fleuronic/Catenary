// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public struct Query {
	private let body: String
}

// MARK: -
public extension Query {
	init(
		name: String,
		type: OperationType = .query,
		argumentList: ArgumentList? = nil,
		fields: [[String]],
		fieldsName: String? = nil,
		slice: (amount: Int, offset: Int)? = nil
	) {
		let fields: any ObjectWeavable = ForEachWeavable(fields, content: \.content)
		var object = Object(name) {
			fieldsName.map {
				Object($0) { fields }
			} ?? fields
		}

		argumentList.map { list in
			for (key, value) in list.arguments {
				object = object.argument(
					key: key,
					value: value
				)
			}
		}

		object = slice.map(object.slice) ?? object
		body = Weave(type) { object }.description
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
		let tail = Self(self[1...])
		return count == 1 ? Field(head) : Object(head) {
			tail.content
		}
	}
}
