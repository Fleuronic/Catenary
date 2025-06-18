// Copyright © Fleuronic LLC. All rights reserved.

import protocol Catena.ResultProviding

public protocol API: ResultProviding where Error == Catenary.Error<APIError> {
	associatedtype APIError: Swift.Error, Equatable
}
