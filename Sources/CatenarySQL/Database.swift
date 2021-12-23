// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Database {
	var types: [AnyModel.Type] { get }
	var storeKeyPath: WritableKeyPath<Self, Store<ReadWrite>> { get }
}

// MARK: -
public extension Database {
	static func createStore() async throws -> Store<ReadWrite> {
		try await open(for: types)
	}

	mutating func clear() async throws {
		try Store.destroy()
		self[keyPath: storeKeyPath] = try await createStore()
	}
}
