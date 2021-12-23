// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Database {
	var types: [AnyModel.Type] { get }
	var storeKeyPath: WritableKeyPath<Self, Store<ReadWrite>> { get }
}

// MARK: -
public extension Database {
	func createStore() async throws -> Store<ReadWrite> {
		try await .open(for: types)
	}

	mutating func clear() async throws {
		try Store<ReadWrite>.destroy()
		try await updateStore()
	}
}

// MARK: -
private extension Database {
	mutating func updateStore() async throws {
		self[keyPath: storeKeyPath] = try await createStore()
	}
}
