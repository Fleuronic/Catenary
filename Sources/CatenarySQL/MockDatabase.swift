// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol MockDatabase {
	init<Model: Schemata.Model>(valueSet: [Model.ID: ValueSet<Model>])
}
