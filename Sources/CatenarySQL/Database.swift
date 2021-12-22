// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Database {
	init() async throws

	mutating func clear() async throws
}
