// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Model: PersistDB.Model, PersistDB.ModelProjection {
	static var identity: Predicate<Self> { get }
	
	var valueSet: ValueSet<Model> { get }
}

// MARK: -
extension Model {
	var identifiedValueSet: ValueSet<Model> {
		valueSet.update(with: [\.id == id])
	}
}

// MARK: -
public extension Model {
	static var idProperty: Property<Self, ID> {
		\.id ~ "id"
	}

	static var defaultOrder: [Ordering<Self>] {
		[.init(\Self.id, ascending: true)]
	}
}
