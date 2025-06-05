// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import SociableWeaver

public struct ArgumentList {
	var arguments: [String: any ArgumentValueRepresentable]

	public init() {
		arguments = [:]
	}

	public init(_ arguments: [String: any ArgumentValueRepresentable]) {
		self.arguments = arguments
	}

	public init<Clause: Catenary.Clause>(_ clause: Clause) {
		var list = Self()
		list.append(clause)
		self = list
	}
}

// MARK: -
public extension ArgumentList {
	mutating func append<Clause: Catenary.Clause>(_ clause: Clause) {
		arguments[Clause.CodingKeys.allCases.first!.rawValue] = clause.body
	}
}

// MARK: -
extension ArgumentList: Encodable {
	// MARK: Encodable
	public func encode(to encoder: any Encoder) throws {}
}

extension ArgumentList: ArgumentValueRepresentable {
	public var argumentValue: String {
		let body = arguments
			.map { "\($0): \($1.argumentValue)" }
			.joined(separator: ", ")

		return "{ \(body) }"
	}
}
