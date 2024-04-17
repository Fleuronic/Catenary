// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.Data
import class Foundation.JSONEncoder

public struct EmptyPayload {
	public init() {}
}

extension EmptyPayload: Payload {
	public func data(using encoder: JSONEncoder) -> Data? { nil }
}
