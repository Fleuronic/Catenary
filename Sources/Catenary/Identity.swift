// Copyright © Fleuronic LLC. All rights reserved.

import struct Identity.Identifier
import protocol Identity.Identifiable
import protocol Catena.Identifying

public extension Identifiable {
	typealias PendingID = PendingIdentifier<Self>
}

// MARK: -
public enum PendingIdentifier<T: Identifiable>: Identifying, Sendable {
	case fromServer
}
