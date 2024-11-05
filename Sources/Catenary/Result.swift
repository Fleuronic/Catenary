// Copyright © Fleuronic LLC. All rights reserved.

public extension Result where Failure: ResourceError {
	#if swift(>=6.0)
	var resource: Success {
		get throws(Failure) {
			try get()
		}
	}
	#else
	var resource: Success {
		get throws {
			try get()
		}
	}
	#endif
}
