// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.ResultProviding

public extension API {
	func result<Resource>(request: @escaping () async throws -> Resource) async -> SingleResult<Resource> {
		do {
			let resource = try await request()
			return .success(resource)
		} catch {
			return .failure(.init(error))
		}
	}
}

public extension Result where Failure: ResourceError {
	#if swift(>=6.0)
	var resource: Success {
		get throws(Failure) {
			try get()
		}
	}

	func validate() throws(Failure) {
		_ = try get()
	}
	#else
	var resource: Success {
		get throws {
			try get()
		}
	}

	func validate() throws {
		_ = try get()
	}
	#endif
}
