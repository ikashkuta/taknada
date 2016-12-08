import Foundation

struct KillMessage: TextRepresentable {} // TODO: move to other place

public struct EntityConfig: TextRepresentable {
    let taggedComponents: [(component: Component, tags: [String])]
    let kind: String
}

open class Environment {

    // MARK: Lifespan

    public init(systems: [System]) {
        self.systems = systems
    }

    // MARK: Entity Creation

    open func make(config: EntityConfig) -> Entity {
        let entity = EntityImpl(kind: config.kind,
                                guid: guidGenerator.getNextGuid(),
                                taggedComponents: config.taggedComponents,
                                environment: self)
        entities.insert(entity)
        return Entity(ref: entity)
    }

    // MARK: Message Dispatching

    open func dispatch(message: TextRepresentable, to entity: Entity) {
        let dispatchFunction = entity.isLocal ? dispatchLocal : dispatchExternal
        dispatchFunction(message, entity)
    }

    private func dispatchLocal(message: TextRepresentable, to entity: Entity) {
        if message is KillMessage {
            guard let ref = entity.ref else { return }
            entities.remove(ref)
            return
        }

        entity.receive(message: message)
    }

    private func dispatchExternal(message: TextRepresentable, to entity: Entity) {
        fatalError("TODO")
    }

    // MARK: URL Namespace System

    open func query(with url: URL) -> [Entity] {
        fatalError("TODO")
    }

    // MARK: Components

    internal func registerComponent(component: Component) {
        systems.forEach { $0.register(component: component) }
    }

    internal func unregisterComponent(component: Component) {
        systems.forEach { $0.unregister(component: component) }
    }

    // MARK: Stuff

    private let systems: [System]
    private var entities = Set<EntityImpl>()
    private var guidGenerator = GuidGenerator()
}

// TODO: Must be thread-safe
private final class GuidGenerator {

    func getNextGuid() -> String {
        let result = String(nextGuid)
        nextGuid += 1
        return result
    }

    private var nextGuid: UInt = 0
}
