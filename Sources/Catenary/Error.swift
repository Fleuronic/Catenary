// Copyright © Fleuronic LLC. All rights reserved.

#if swift(<5.9)
import class Foundation.NSError
#else
public import class Foundation.NSError
#endif

public enum Error<Error: Swift.Error & Equatable & CustomStringConvertible>: Swift.Error & Equatable {
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

extension DecodingError: Swift.Equatable {
	public static func ==(lhs: Self, rhs: Self) -> Bool {
		lhs.errorDescription == rhs.errorDescription
	}
}

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
