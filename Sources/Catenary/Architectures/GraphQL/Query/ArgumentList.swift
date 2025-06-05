// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import SociableWeaver

public struct ArgumentList: Sendable {
	var arguments: Arguments

	public init() {
		arguments = [:]
	}

	public init(_ arguments: Arguments) {
		self.arguments = arguments
	}

	public init<Clause: Catenary.Clause>(_ clause: Clause) {
		var list = Self()
		list.append(clause)
		self = list
	}

	public init<Model, each T: ArgumentValueRepresentable & Sendable>(
		schema: Schema,
		_ pairs: repeat (KeyPath<Model, each T>, each T)
	) {
		var arguments: Arguments = [:]
		for (key, value) in repeat each pairs {
			arguments[schema[key].joined(separator: "_")] = value
		}
	
		self.arguments = arguments
	}
}

// MARK: -
public extension ArgumentList {
	typealias Arguments = [String: any ArgumentValueRepresentable & Sendable]

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
