// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Database {
	mutating func clear() async throws
}
