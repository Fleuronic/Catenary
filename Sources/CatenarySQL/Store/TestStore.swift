// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

extension TestStore: ReadWriteStore {
	public func insert<Model: CatenarySQL.Model>(_ model: Model) async where Model == Model.Model {
		insert(.init(model.identifiedValueSet))
	}

	public func update<Model>(_ model: Model.Type, with id: Model.ID, using valueSet: ValueSet<Model>) async {
		update(.init(predicate: \Model.id == id, valueSet: valueSet))
	}

	public func delete<Model: CatenarySQL.Model>(_ model: Model.Type, with id: Model.ID) async {
		delete(.init(\Model.id == id))
	}
}
