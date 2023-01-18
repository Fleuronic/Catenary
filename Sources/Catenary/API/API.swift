// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URL
import class Foundation.JSONDecoder

public protocol API {
	associatedtype Response: APIResponse
	associatedtype Error: APIError

	var baseURL: URL { get }
	var decoder: JSONDecoder { get }
}

// MARK: -
public extension API {
	typealias Result<Resource> = Swift.Result<Resource, Request.Error<Error>>

	var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}
}
