// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields
import protocol Catena.Valued

public protocol Input: Catena.Fields where Model: Valued {
	var value: Model.Value { get }
	var argumentList: ArgumentList { get }
}
