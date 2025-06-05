// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver
import protocol Catena.Fields
import protocol Catena.Valued

public protocol Input<Schematic>: Catena.Fields where Model: Valued {
	associatedtype Schematic: Catenary.Schematic

	var value: Model.Value { get }
	var argumentList: ArgumentList { get }
}
