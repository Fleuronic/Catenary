// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Database {
	init() async throws
	
	func clear() async throws
}
