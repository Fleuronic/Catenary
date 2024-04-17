// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URLQueryItem
import class DictionaryCoder.DictionaryEncoder

public protocol Parameters: Encodable {
	var queryItems: [URLQueryItem] { get throws }
}

// MARK: -
public extension Parameters {
	var queryItems: [URLQueryItem] {
		get throws {
			let encoder = DictionaryEncoder()
			return try encoder.encode(self).map { name, value in
				.init(
					name: name,
					value: "\(value)"
				)
			}
		}
	}
}
