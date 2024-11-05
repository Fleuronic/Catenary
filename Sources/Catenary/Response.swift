// Copyright © Fleuronic LLC. All rights reserved.

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
