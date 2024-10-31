// Copyright © Fleuronic LLC. All rights reserved.

public protocol API: Sendable {
	associatedtype Error: Swift.Error & Equatable & CustomStringConvertible
}

// MARK: -
public extension API {
	typealias Response<Resource> = Result<Resource, Catenary.Error<Error>>

	func response<Resource>(request: @escaping () async throws -> Resource) async -> Response<Resource> {
		do {
			let resource = try await request()
			return .success(resource)
		} catch {
			return .failure(.init(error))
		}
	}
}

// MARK: -
public extension Result where Failure: ResourceError {
	#if swift(>=6.0)
	var resource: Success {
		get throws(Failure) {
			try get()
		}
	}
	#else
	var resource: Success {
		get throws {
			try get()
		}
	}
	#endif
}
