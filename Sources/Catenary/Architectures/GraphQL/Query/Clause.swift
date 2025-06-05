// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public protocol Clause<Body>: Encodable {
	associatedtype Body: ArgumentValueRepresentable
	associatedtype CodingKeys: CodingKey, RawRepresentable, CaseIterable where CodingKeys.RawValue == String

	var body: Body { get }
}
