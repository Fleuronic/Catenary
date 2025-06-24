// Copyright © Fleuronic LLC. All rights reserved.

import SociableWeaver

public struct ArgumentList: Sendable {
	var arguments: Arguments

	private init(_ arguments: Arguments) {
		self.arguments = arguments
	}
}

// MARK: -
public extension ArgumentList {
	init() {
		self.init([:])
	}

	init<Clause: Catenary.Clause>(_ clause: Clause) {
		var list = Self([:])
		list.append(clause)
		self = list
	}

	mutating func append<Clause: Catenary.Clause>(_ clause: Clause) {
		arguments[Clause.name] = clause.body
	}
}

// MARk: -
extension ArgumentList {
	typealias Arguments = [String: any ArgumentValueRepresentable & Sendable]
}
