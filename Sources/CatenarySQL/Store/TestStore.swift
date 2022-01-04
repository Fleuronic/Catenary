// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public extension TestStore {
	func insert<Model: CatenarySQL.Model>(_ model: Model) {
		let _: Model = insert(.init(model.identifiedValueSet))
	}

	func update<Model>(_ model: Model.Type, with id: Model.ID, using valueSet: ValueSet<Model>) {
		update(.init(predicate: \Model.id == id, valueSet: valueSet))
	}

	func delete<Model: CatenarySQL.Model>(_ model: Model.Type, with id: Model.ID) {
		delete(.init(\Model.id == id))
	}
}
