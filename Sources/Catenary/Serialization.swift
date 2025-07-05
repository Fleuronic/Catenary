import Identity

public protocol Deserializable: Identifiable {
	associatedtype Container: KeyedDecodingContainerProtocol

	static func deserialized(from decoder: any Decoder) throws -> (ID, Container)
}
