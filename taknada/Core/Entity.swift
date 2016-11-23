import Foundation

internal final class Entity {

	// MARK: Lifespan

	deinit {
		self.components.forEach {
			self.environment.unregisterComponent(component: $0)
			$0.unregister()
		}
	}

	init(kind: String,
	     guid: UInt,
	     components: [Component.Type],
	     environment: Environment) {
		self.environment = environment
		self.components = components.map { $0.init() }

		self.storage["kind"] = kind
		self.storage["guid"] = guid

		let ref = EntityRef(ref: self)
		self.components.forEach {
			$0.register(entity: ref)
			self.environment.registerComponent(component: $0)
		}
	}

	// MARK: API

	func write(key: String, data: Textable, persistent: Bool) {
		// TODO: persistence
		self.storage[key] = data
	}

	func read(key: String) -> Textable? {
		return self.storage[key]
	}

	func subscribe(key: String) -> Observable<Textable> {
		return Observable()
	}

	func receive(message: Textable) {
	}

	// MARK: Stuff

	internal var storage = [String: Textable]()

	private unowned let environment: Environment
	private let components: [Component]
}

extension Entity: Equatable {

	static func ==(lhs: Entity, rhs: Entity) -> Bool {
		return lhs === rhs
	}
}

extension Entity: Hashable {

	var hashValue: Int {
		return Unmanaged.passUnretained(self).toOpaque().hashValue
	}
}
