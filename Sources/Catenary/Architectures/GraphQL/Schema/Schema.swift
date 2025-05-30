// Copyright © Fleuronic LLC. All rights reserved.

public struct Schema {
	private let body: [AnyKeyPath: [String]]

	public init(
		components: Set<Component>,
		maxDepth: Int = 2
	) {
		var count = 0
		var components = components
		var reachedMaxDepth = false
		var body: [AnyKeyPath: [String]] = [:]

		while count < components.count && !reachedMaxDepth {
			count = components.count
			for (i, a) in components.enumerated() {
				for (j, b) in components.enumerated() {
					guard i != j else { continue }
					if let result = a.keyPath.appending(path: b.keyPath) {
						let pathComponents = a.pathComponents + b.pathComponents
						if Set(pathComponents).count == 1 && pathComponents.count > maxDepth {
							reachedMaxDepth = true
						}

						components.insert(
							.init(
								keyPath: result,
								pathComponents: pathComponents
							)
						)
					}
				}
			}
		}

		for component in components {
			body[component.keyPath] = component.pathComponents
		}

		self.body = body
	}
}

// MARK: -
public extension Schema {
	subscript (keyPath: AnyKeyPath) -> [String] {
		body[keyPath]!
	}
}
