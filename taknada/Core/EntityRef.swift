import Foundation

public struct EntityRef {

	// MARK: Lifespan

	internal init(ref: Entity) {
		self.ref = ref
	}

	// MARK: Stuff

	internal weak var ref: Entity?
    internal let isLocal: Bool = true
}

extension EntityRef: Textable {
}

extension EntityRef { // Minidb

	public func write(key: String, data: Textable, persistent: Bool) {
		self.ref?.write(key: key, data: data, persistent: persistent)
	}

	public func read<T: Textable>(key: String) -> T? {
		return self.ref?.read(key: key) as? T
	}

	public func subscribe(key: String) -> Observable<Textable>? {
		return self.ref?.subscribe(key: key)
	}
}

extension EntityRef { // Messages

    public func receive(message: Textable) { // incoming messages
        self.ref?.receive(message: message)
    }

	public func post(message: Textable) { // outgoing messages
		self.ref?.post(message: message)
	}
}

extension EntityRef { // Convenience vars

	public var kind: String {
		return self.read(key: "kind")!
	}

	public var guid: String {
		return self.read(key: "guid")!
	}
}
