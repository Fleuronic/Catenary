// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URLRequest

public extension Request {
	struct Header {
		let field: String
		let value: String

		public init(
			field: String,
			value: String
		) {
			self.field = field
			self.value = value
		}
	}
}

// MARK: -
extension Request.Header {
	static var jsonContentType: Self {
		.init(
			field: "Content-Type",
			value: "application/json"
		)
	}
}

// MARK: -
extension URLRequest {
	mutating func apply(_ header: Request.Header) {
		setValue(header.value, forHTTPHeaderField: header.field)
	}
}
