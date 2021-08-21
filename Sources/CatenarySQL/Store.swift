// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Combine
import AsyncExtensions
import ReactiveCombineBridge
import Schemata
import PersistDB

public extension Store {
	func fetch<Projection: PersistDB.ModelProjection>(_ id: Projection.Model.ID) async -> Projection? {
		await fetch(id).publisher().singleValue
	}

	func fetch<Key, Projection: PersistDB.ModelProjection>(_ query: Query<Key, Projection.Model>) async -> ResultSet<Key, Projection> {
		await fetch(query).publisher().singleValue
	}

	func fetch<Model, Value>(_ aggregate: Aggregate<Model, Value>) async -> Value {
		await observe(aggregate).publisher().singleValue
	}

	func observe<Projection: PersistDB.ModelProjection>(_ id: Projection.Model.ID) -> AnyPublisher<Projection?, Never> {
		observe(id).publisher().eraseToAnyPublisher()
	}

	func observe<Key, Projection: PersistDB.ModelProjection>(_ query: Query<Key, Projection.Model>) -> AnyPublisher<ResultSet<Key, Projection>, Never> {
		observe(query).publisher().eraseToAnyPublisher()
	}

	func observe<Model, Value>(_ aggregate: Aggregate<Model, Value>) -> AnyPublisher<Value, Never> {
		observe(aggregate).publisher().eraseToAnyPublisher()
	}
}

public extension Store where Mode == ReadWrite {
	func insert<Model>(_ insert: Insert<Model>) async -> Model.ID {
		await self.insert(insert).publisher().singleValue
	}

	func update<Model>(_ update: Update<Model>) async {
		await self.update(update).publisher().singleValue
	}

	func delete<Model>(_ delete: Delete<Model>) async {
		await self.delete(delete).publisher().singleValue
	}

	func clear() throws {
		try FileManager.default.removeItem(at: url)
	}

	static func open(for types: [AnyModel.Type]) async throws -> Store {
		try await Store<ReadWrite>
			.open(libraryNamed: .database, for: types)
			.publisher()
			.singleValue
	}
}

// MARK: -
private extension Store {
	var url: URL {
		get throws {
			try FileManager.default
				.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
				.appendingPathComponent(.database)
		}
	}
}

// MARK: -
private extension String {
	static let database = "Database"
}
