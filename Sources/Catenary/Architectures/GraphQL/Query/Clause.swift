// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public protocol Clause {
	associatedtype Body: ArgumentValueRepresentable & Sendable

	var body: Body { get }

	static var name: String { get }
}
