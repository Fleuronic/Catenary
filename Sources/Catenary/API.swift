// Copyright © Fleuronic LLC. All rights reserved.

public protocol API: Sendable {
	associatedtype Error: Swift.Error & Equatable
}
