// Copyright © Fleuronic LLC. All rights reserved.

public extension Schema {
	struct Component: Hashable {
		public let keyPath: AnyKeyPath
		public let pathComponents: [String]

		public init(
			keyPath: AnyKeyPath,
			pathComponents: [String]
		) {
			self.keyPath = keyPath
			self.pathComponents = pathComponents
		}
	}
}
