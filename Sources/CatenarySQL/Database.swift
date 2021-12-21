// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

public protocol Database {}

// MARK: -
public extension Database {
	static func clear() throws {
		try Store<ReadWrite>.destroy()
	}
}
