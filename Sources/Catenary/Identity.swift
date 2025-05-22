// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Identifying
import protocol Identity.Identifiable

public extension Identifiable {
	typealias PendingID = PendingIdentifier<Self>
}

// MARK: -
public enum PendingIdentifier<Identified: Identifiable>: Identifying, Sendable {
	case fromServer
}
