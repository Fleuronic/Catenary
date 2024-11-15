// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.ResultProviding

public protocol API: ResultProviding, Sendable where Error == Catenary.Error<APIError> {
	associatedtype APIError: Swift.Error, Equatable
}
