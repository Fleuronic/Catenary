// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Model: PersistDB.Model, PersistDB.ModelProjection {
	var valueSet: ValueSet<Model> { get }
	var identifiedValueSet: ValueSet<Model> { get }

	static var defaultOrder: [Ordering<Self>] { get }
}
