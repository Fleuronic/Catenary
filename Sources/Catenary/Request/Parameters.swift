// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URLQueryItem

public protocol Parameters {
	var names: [PartialKeyPath<Self>: String] { get }
}

public extension Parameters {
	var queryItems: [URLQueryItem] {
		names.map { keyPath, name in
			.init(
				name: name,
				value: "\(self[keyPath: keyPath])"
			)
		}
	}
}

struct EmptyParameters: Parameters {
	var names: [PartialKeyPath<Self>: String] { [:] }
}
