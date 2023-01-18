// Copyright © Fleuronic LLC. All rights reserved.

public protocol APIError: Error, Decodable {
	var message: String { get }
}
