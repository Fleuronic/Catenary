// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Database {
	var storeKeyPath: WritableKeyPath<Self, Store<ReadWrite>> { get }

	static var types: [AnyModel.Type] { get }
}

// MARK: -
public extension Database {
	mutating func clear() async throws {
		try Store.destroy()
		self[keyPath: storeKeyPath] = try await Self.createStore()
	}

	static func createStore() async throws -> Store<ReadWrite> {
		try await .open(for: types)
	}
}
