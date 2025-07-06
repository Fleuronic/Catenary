import Identity

public protocol Deserializable: Identifiable {
	associatedtype Container: KeyedDecodingContainerProtocol

	static func deserialized(from decoder: any Decoder) -> (ID, Container)
}

// MARK: -
public extension KeyedDecodingContainer {
	func decode<T: Decodable>(for key: K) -> T {
		try! decode(T.self, forKey: key)
	}
}
