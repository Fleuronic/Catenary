// Copyright © Fleuronic LLC. All rights reserved.

public extension Request {
	enum State<Resource, Error: Swift.Error> {
		case idle
		case requesting
		case retrieved(Resource)
		case failed(Error)
	}
}

// MARK: -
public extension Request.State {
	var isRequesting: Bool {
		switch self {
		case .requesting:
			return true
		default:
			return false
		}
	}

	func mapRequesting<T>(_ value: T) -> T? {
		switch self {
		case .requesting:
			return value
		default:
			return nil
		}
	}

	func mapError<T>(_ value: T) -> T? {
		switch self {
		case .failed:
			return value
		default:
			return nil
		}
	}

	func mapError<T>(_ transform: (Error) -> T) -> T? {
		switch self {
		case let .failed(error):
			return transform(error)
		default:
			return nil
		}
	}
}
