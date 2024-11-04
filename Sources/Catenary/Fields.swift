// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields

public protocol Fields: Catena.Fields  {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { get }
}

// MARK: -
public extension Fields {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { [:] }
}
