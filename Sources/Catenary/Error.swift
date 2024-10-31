// Copyright © Fleuronic LLC. All rights reserved.

import class Foundation.NSError

public enum Error<Error: Swift.Error & Equatable & CustomStringConvertible>: ResourceError {
	case api(Error)
	case undocumented(message: String)
	case decoding(DecodingError)
	case network(NSError)
}

// MARK: -
public extension Error {
	init(_ error: some Swift.Error) {
		if let error = error as? Self {
			self = error
		} else if let error = error as? Error {
			self = .api(error)
		} else if let error = error as? DecodingError {
			self = .decoding(error)
		} else {
			self = .network(error as NSError)
		}
	}
}

// MARK: -
extension DecodingError: Swift.Equatable {
	public static func ==(lhs: Self, rhs: Self) -> Bool {
		lhs.errorDescription == rhs.errorDescription
	}
}

// MARK: -
extension Error: CustomStringConvertible {
	public var description: String {
		switch self {
		case let .api(error): return error.description
		case let .undocumented(message): return message
		case let .decoding(error): return "\(error)"
		case let .network(error): return error.localizedDescription
		}
	}
}

// MARK: -
public protocol ResourceError: Swift.Error & Equatable {}
