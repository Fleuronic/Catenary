// Copyright © Fleuronic LLC. All rights reserved.

import struct Catena.IDFields
import protocol Catena.Fields

public protocol Fields: Catena.Fields  {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { get }
}

// MARK: -
public extension Fields {
	var missingFields: [PartialKeyPath<Self>] {
		undocumentedFields.filter(\.value).map(\.key)
	}

	// MARK: Fields
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { [:] }
}

// MARK: -
extension IDFields: Fields {}
