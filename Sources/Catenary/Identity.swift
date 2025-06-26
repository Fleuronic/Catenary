// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import SociableWeaver
import protocol Catena.Identifying

public extension Identifiable {
	typealias PendingID = PendingIdentifier<Self>
}

// MARK: -
extension Identifier: SociableWeaver.ArgumentValueRepresentable {
	public var argumentValue: String { "\"\(description)\"" }
}

// MARK: -
public enum PendingIdentifier<Identified: Identifiable>: Identifying, Sendable {
	case fromServer
}
