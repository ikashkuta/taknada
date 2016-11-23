import Foundation

public struct EntityRef {

	// MARK: Lifespan

	internal init(ref: Entity) {
		self.ref = ref
	}

	// MARK: Stuff

	internal weak var ref: Entity?
}

extension EntityRef: Textable {
}

extension EntityRef { // Minidb

	public func write<T: Textable>(key: String, data: T, persistent: Bool) {
		self.ref?.write(key: key, data: data, persistent: persistent)
	}

	public func read<T: Textable>(key: String) -> T? {
		return self.ref?.read(key: key) as? T
	}

	public func subscribe(key: String) -> Observable<Textable>? {
		return self.ref?.subscribe(key: key)
	}
}

extension EntityRef { // Postbox

//	public func receive() -> Observable<Textable> {
//		self.ref?.receive(message: Textable)
//	}

	public func post<T: Textable>(message: T) {
		
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
