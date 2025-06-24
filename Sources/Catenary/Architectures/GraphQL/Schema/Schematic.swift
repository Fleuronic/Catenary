// Copyright © Fleuronic LLC. All rights reserved.

public protocol Schematic {
	static var schema: Schema { get }
	static var enumValues: [String] { get }
}

public extension Schematic {
	static var enumValues: [String] { [] }
}
