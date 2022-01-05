// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol ReadWriteStore {
	func insert<Model: CatenarySQL.Model>(_ model: Model) async
	func fetch<Projection: PersistDB.ModelProjection>(_ query: Query<None, Projection.Model>) async -> [Projection]
	func update<Model: CatenarySQL.Model>(_ modelType: Model.Type, with id: Model.ID, using valueSet: ValueSet<Model>) async
	func delete<Model: CatenarySQL.Model>(_ modelType: Model.Type, with id: Model.ID) async
}
