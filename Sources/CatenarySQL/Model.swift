// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB
import Identity

public protocol Model: ModelProjection, Identifiable where Self == Model, ID == Identifier<Self> {
	var id: ID { get }
	var valueSet: ValueSet<Self> { get }
}

// MARK: -
extension Model {
	var identifiedValueSet: ValueSet<Self> {
		valueSet.update(with: [\.id == id])
	}
}

// MARK: -
public extension Model {
	static var defaultOrder: [Ordering<Self>] {
		[.init(\.id, ascending: true)]
	}
}
