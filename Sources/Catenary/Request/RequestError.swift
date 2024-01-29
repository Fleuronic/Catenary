// Copyright © Fleuronic LLC. All rights reserved.

import class Foundation.NSError

public extension Request {
	enum Error<Error: APIError> {
		case api(Error)
		case network(NSError)
		case decoding(DecodingError)
	}
}

// MARK: -
public extension Request.Error {
	var message: String {
		switch self {
		case let .api(error): error.message
		case let .network(error): error.localizedDescription
		case let .decoding(error): error.localizedDescription
		}
	}
}

// MARK: -
extension Request.Error: Swift.Error {}
