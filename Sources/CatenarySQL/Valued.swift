// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Valued: PersistDB.ModelProjection {
	var valueSet: ValueSet<Model> { get }
}
