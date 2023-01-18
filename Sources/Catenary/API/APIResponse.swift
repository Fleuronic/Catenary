// Copyright © Fleuronic LLC. All rights reserved.

public protocol APIResponse: Decodable {
	func resource<Resource: Decodable>() throws -> Resource
}
