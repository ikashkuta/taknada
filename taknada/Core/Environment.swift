import Foundation

open class Environment {

	// MARK: Lifespan

	public init(systems: [System]) {
		self.systems = systems
	}

	// MARK: API

	open func dispatch(message: Textable, to entity: EntityRef) {
        entity.receive(message: message)
	}

	open func dispatch(message: Textable, from entity: EntityRef) {
        fatalError("TODO")
	}

	open func addRoute(from fromEntity: EntityRef, to toEntity: EntityRef) {
	}

	open func removeRoute(from fromEntity: EntityRef, to toEntity: EntityRef) {
	}

	open func query(with url: URL) -> [EntityRef] {
		return []
	}

	open func make() -> EntityRef {
		let entity = Entity(kind: "", guid: self.guidGenerator.getNextGuid(), components: [], environment: self)
		return EntityRef(ref: entity)
	}

	// MARK: Components

	internal func registerComponent(component: Component) {
		self.systems.forEach { $0.register(component: component) }
	}

	internal func unregisterComponent(component: Component) {
		self.systems.forEach { $0.unregister(component: component) }
	}

    // MARK: Stuff

	private let systems: [System]
	private var entities = Set<Entity>()
    private var guidGenerator = GuidGenerator()
}

// TODO: Must be thread-safe
private final class GuidGenerator {

    func getNextGuid() -> String {
        let result = String(self.nextGuid)
        self.nextGuid += 1
        return result
    }

    private var nextGuid: UInt = 0
}
