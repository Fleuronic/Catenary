// Copyright © Fleuronic LLC. All rights reserved.

extension Response.Data {
	struct Key {
		let intValue: Int?
		let stringValue: String
	}
}

// MARK: -
extension Response.Data.Key: CodingKey {
	init?(intValue: Int) {
		self.intValue = intValue
		stringValue = .init(describing: intValue)
	}

	init?(stringValue: String) {
		intValue = nil
		self.stringValue = stringValue
	}
}

