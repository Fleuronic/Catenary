// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.Identifying
import protocol Identity.Identifiable

public enum PendingIdentifier<Model: Identifiable>: Identifying, Sendable {
	case fromServer
}

// MARK: -
public extension Identifiable {
	typealias PendingID = PendingIdentifier<Self>
}
