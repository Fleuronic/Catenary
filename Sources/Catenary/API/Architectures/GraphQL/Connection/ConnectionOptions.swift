// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

extension GraphQL.Connection {
	@Init public struct Options: OptionSet {
		public let rawValue: Int

		public static let edges = Self(rawValue: 1 << 0)
		public static let nodes = Self(rawValue: 1 << 1)
		public static let pageInfo = Self(rawValue: 1 << 2)
	}
}

extension GraphQL.Connection.Options {
	var field: String! {
		switch self {
		case .edges: "edges"
		case .nodes: "nodes"
		case .pageInfo: "pageInfo"
		default: nil
		}
	}
}
