// Copyright © Fleuronic LLC. All rights reserved.

public extension Schema {
	struct Component: Hashable {
		let keyPath: AnyKeyPath
		let pathComponents: [String]

		public init(
			keyPath: AnyKeyPath,
			pathComponents: [String]
		) {
			self.keyPath = keyPath
			self.pathComponents = pathComponents
		}
	}
}
