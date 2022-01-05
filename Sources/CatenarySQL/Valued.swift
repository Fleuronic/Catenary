// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Valued: PersistDB.ModelProjection {
	var valueSet: ValueSet<Model> { get }
}

// MARK: -
public extension Valued {
	var valueSet: ValueSet<Model> { .init() }
}
