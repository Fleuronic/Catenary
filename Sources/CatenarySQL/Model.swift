// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Model: PersistDB.Model, Valued {}

// MARK: -
extension Model where Model == Self {
	var identifiedValueSet: ValueSet<Model> {
		valueSet.update(with: [\.id == id])
	}
}

// MARK: -
public extension Model {
	static var idProperty: Property<Self, ID> {
		idKeyPath ~ "id"
	}

	static var idKeyPath: KeyPath<Self, ID> {
		\.id
	}

	static var defaultOrder: [Ordering<Self>] {
		[.init(idKeyPath, ascending: true)]
	}
}
