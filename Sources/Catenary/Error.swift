// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public enum Error<Error: Swift.Error & Equatable>: ResourceError {
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

	static func type(_: Never) -> Self {}
}

// MARK: -
extension DecodingError: Swift.Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.errorDescription == rhs.errorDescription
	}
}

// MARK: -
extension Error: CustomStringConvertible {
	public var description: String {
		switch self {
		case let .api(error): "\(error)"
		case let .undocumented(message): message
		case let .decoding(error): "\(error)"
		case let .network(error): error.localizedDescription
		}
	}
}

// MARK: -
public protocol ResourceError: Swift.Error & Equatable {}
