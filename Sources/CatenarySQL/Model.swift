// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Identity

public protocol Model: PersistDB.Model, PersistDB.ModelProjection, Identifiable {
	var valueSet: ValueSet<Model> { get }
	var identifiedValueSet: ValueSet<Model> { get }
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
