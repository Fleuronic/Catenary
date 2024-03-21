// Copyright © Fleuronic LLC. All rights reserved.

public struct DynamicKey: CodingKey {
	public var intValue: Int?
	public var stringValue: String

	public init?(intValue: Int) {
		self.intValue = intValue
		stringValue = .init(describing: intValue)
	}

	public init?(stringValue: String) {
		intValue = nil
		self.stringValue = stringValue
	}
}
