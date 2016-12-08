import Foundation

struct KillMessage: Textable {}

open class Environment {

	// MARK: Lifespan

    deinit {
        fatalError("TODO") // unregister anything, cleanup, etc.
    }

	public init(systems: [System]) {
		self.systems = systems
	}

	// MARK: Message Dispatching

	open func dispatch(message: Textable, to entity: EntityRef) {
        let dispatchFunction = entity.isLocal ? self.dispatchLocal : self.dispatchExternal
        dispatchFunction(message, entity)
	}

    private func dispatchLocal(message: Textable, to entity: EntityRef) {
        guard let ref = entity.ref else {
            fatalError("TODO: Remove outdated route")
        }

        if message is KillMessage {
            self.entities.remove(ref)
            return
        }

        entity.receive(message: message)
    }

    private func dispatchExternal(message: Textable, to entity: EntityRef) {
        fatalError("TODO")
    }

    // MARK: URL Namespace System

	open func query(with url: URL) -> [EntityRef] {
        fatalError("TODO")
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
