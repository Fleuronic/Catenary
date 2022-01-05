// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol ReadWriteStore {
	func insert<Model: CatenarySQL.Model>(_ model: Model) async
	func update<Model>(_ model: Model.Type, with id: Model.ID, using valueSet: ValueSet<Model>) async
	func delete<Model: CatenarySQL.Model>(_ model: Model.Type, with id: Model.ID) async
}
