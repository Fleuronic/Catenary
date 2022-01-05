// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Valued {
	associatedtype Model: PersistDB.Model

	var valueSet: ValueSet<Model> { get }
}
