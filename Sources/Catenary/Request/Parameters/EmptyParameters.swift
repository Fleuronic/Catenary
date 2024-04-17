// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URLQueryItem

public struct EmptyParameters {
	public init() {}
}

extension EmptyParameters: Parameters {
	public var queryItems: [URLQueryItem] { [] }
}
