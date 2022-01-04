// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Identity

public protocol Model: PersistDB.Model, PersistDB.ModelProjection, Identifiable where ID == Identifier<Self> {
	var id: ID { get }
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
	static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: true)]
	}
}
