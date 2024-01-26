// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.URL
import class Foundation.JSONDecoder
import class Foundation.JSONEncoder

public protocol API {
	associatedtype Response: APIResponse
	associatedtype Error: APIError

	var authenticationHeader: Request.Header? { get }
	var decoder: JSONDecoder { get }
	var encoder: JSONEncoder { get }

	func url(forPath path: String) -> URL
}

// MARK: -
public extension API {
	typealias Result<Resource> = Swift.Result<Resource, Request.Error<Error>>

	var authenticationHeader: Request.Header? { nil }

	var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}

	var encoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return encoder
	}
}
