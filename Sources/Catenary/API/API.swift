// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol API {
	associatedtype Response: APIResponse
	associatedtype Error: APIError

	var baseURL: URL { get }
	var decoder: JSONDecoder { get }
	var encoder: JSONEncoder { get }
}

// MARK: -
public extension API {
	typealias Result<Resource> = Swift.Result<Resource, Request.Error<Error>>

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
