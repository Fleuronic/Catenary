// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Combine
import AsyncExtensions
import ReactiveCombineBridge
import Schemata
import PersistDB

public extension Store {
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
	static func open(for types: [AnyModel.Type]) async throws -> Store {
		try await Store<ReadWrite>
			.open(libraryNamed: .database, for: types)
			.publisher()
			.singleValue
	}

	static func destroy() throws {
		try FileManager.default.removeItem(at: url)
	}
}

// MARK: -
extension Store: ReadWriteStore where Mode == ReadWrite {
	public func insert<Model: CatenarySQL.Model>(_ model: Model) async where Model == Model.Model {
		await insert(.init(model.identifiedValueSet))
			.publisher()
			.ignoreOutput()
			.completion
	}

	public func fetch<Projection: PersistDB.ModelProjection>(_ query: Query<None, Projection.Model>) async -> [Projection] {
		await fetch(query)
			.publisher()
			.singleValue
			.values
	}

	public func update<Model>(_ model: Model.Type, with id: Model.ID, using valueSet: ValueSet<Model>) async {
		await update(.init(predicate: \Model.id == id, valueSet: valueSet))
			.publisher()
			.completion
	}

	public func delete<Model: CatenarySQL.Model>(_ model: Model.Type, with id: Model.ID) async {
		await delete(.init(\Model.id == id))
			.publisher()
			.completion
	}
}

// MARK: -
private extension Store {
	static var url: URL {
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
