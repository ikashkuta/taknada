import Foundation

open class Environment {

	// MARK: Lifespan

	public init(systems: [System]) {
		self.systems = systems
	}

	// MARK: API

	open func dispatch(message: Textable, to entity: EntityRef) {
	}

	open func dispatch(message: Textable, from entity: EntityRef) {
	}

	open func addRoute(from fromEntity: EntityRef, to toEntity: EntityRef) {
	}

	open func removeRoute(from fromEntity: EntityRef, to toEntity: EntityRef) {
	}

	open func query(with url: URL) -> [EntityRef] {
		return []
	}

	open func make() -> EntityRef {
		let entity = Entity(kind: "", guid: 0, components: [], environment: self)
		return EntityRef(ref: entity)
	}

	// MARK: Stuff

	internal func registerComponent(component: Component) {
		self.systems.forEach { $0.register(component: component) }
	}

	internal func unregisterComponent(component: Component) {
		self.systems.forEach { $0.unregister(component: component) }
	}

	private let systems: [System]
	private var entities = Set<Entity>()

	// TODO: Make thread-safe
	private func getNextGuid() -> UInt {
		let result = self.guidFactory
		self.guidFactory += 1
		return result
	}
	private var guidFactory: UInt = 0
}
