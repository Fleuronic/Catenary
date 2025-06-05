// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Fields

public protocol Fields: Catena.Fields, Decodable  {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { get }

	static func decoded(from decoder: any Decoder) throws -> Self
}

// MARK: -
public extension Fields {
	var missingFields: [PartialKeyPath<Self>] {
		undocumentedFields.filter(\.value).map(\.key)
	}

	// MARK: Decodable
	init(from decoder: any Decoder) throws {
		self = try Self.decoded(from: decoder)
	}

	// MARK: Fields
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { [:] }
}

// MARK: -
public extension KeyedDecodingContainer {
	func decode<T: Decodable>(for key: K) throws -> T {
		try decode(T.self, forKey: key)
	}

	func decodeIfPresent<T: Decodable>(for key: K) throws -> T? {
		try decodeIfPresent(T.self, forKey: key)
	}
}
