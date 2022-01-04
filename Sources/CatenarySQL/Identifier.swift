// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Schemata

extension Identifier: AnyModelValue where Value.RawIdentifier == Int {}

// MARK: -
extension Identifier: ModelValue where Value.RawIdentifier == Int {
	public static var value: Schemata.Value<Int, Self> {
		Int.value.bimap(
			decode: Self.init(rawValue:),
			encode: \.rawValue
		)
	}
}

