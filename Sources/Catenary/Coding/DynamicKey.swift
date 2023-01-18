// Copyright © Fleuronic LLC. All rights reserved.

struct DynamicKey: CodingKey {
	var intValue: Int?
	var stringValue: String

	init?(intValue: Int) {
		self.intValue = intValue
		stringValue = .init(describing: intValue)
	}

	init?(stringValue: String) {
		intValue = nil
		self.stringValue = stringValue
	}
}
