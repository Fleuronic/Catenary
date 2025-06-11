// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public protocol Clause<Body, Model, Schematic>: Encodable {
	associatedtype Model
	associatedtype Body: ArgumentValueRepresentable & Sendable
	associatedtype Schematic: Catenary.Schematic
	associatedtype CodingKeys: CodingKey, RawRepresentable, CaseIterable where CodingKeys.RawValue == String

	var body: Body { get }
}
