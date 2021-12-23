// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Database {
	typealias StoreKeyPath = WritableKeyPath<Self, Store<ReadWrite>>

	var storeKeyPath: StoreKeyPath { get }

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
