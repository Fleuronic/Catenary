// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URLQueryItem
import class Foundation.JSONEncoder
import class Foundation.JSONSerialization

public protocol Parameters: Encodable {}

// MARK: -
public extension Parameters {
	var queryItems: [URLQueryItem] {
		get throws {
			let encoder = JSONEncoder()
			let data = try encoder.encode(self)
			let object = try JSONSerialization.jsonObject(with: data) as! [String: Any]

			return object.map { name, value in
				.init(
					name: name,
					value: "\(value)"
				)
			}
		}
	}
}

// MARK: -
struct EmptyParameters: Parameters {}
