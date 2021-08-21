// Copyright © Fleuronic LLC. All rights reserved.

public protocol Connection {
	associatedtype Database

	func open() -> Database
	func close() throws
}
