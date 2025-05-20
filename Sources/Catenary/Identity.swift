// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Identifying
import protocol Identity.Identifiable

public extension Identifiable {
	typealias PendingID = PendingIdentifier<Self>
}

// MARK: -
public enum PendingIdentifier<T: Identifiable>: Identifying, Sendable {
	case fromServer
}
