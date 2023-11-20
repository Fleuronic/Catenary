// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

import struct Foundation.URLRequest

extension Request {
	@Init public struct Header {
		let field: String
		let value: String
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
