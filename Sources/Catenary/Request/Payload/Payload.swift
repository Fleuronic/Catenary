// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.Data
import class Foundation.JSONEncoder

public protocol Payload: Encodable {
	func data(using encoder: JSONEncoder) -> Data?
}

// MARK: -
public extension Parameters {
	func data(using encoder: JSONEncoder) -> Data? {
		try! encoder.encode(self)
	}
}
