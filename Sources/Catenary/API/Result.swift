// Copyright © Fleuronic LLC. All rights reserved.

public extension Result {
	func asyncMap<NewSuccess>(_ transform: (Success) async -> NewSuccess) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value):
			return .success(await transform(value))
		case let .failure(error):
			return .failure(error)
		}
	}

	func asyncFlatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value):
			return await transform(value)
		case let .failure(error):
			return .failure(error)
		}
	}
}
