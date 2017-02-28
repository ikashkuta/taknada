import Foundation

/// Entity may be described by following set of things:
/// 1. Name: every entity in the world should have it's name
/// 2. Tagged components: parts of the entity, head-body-hands(tags: left & right)-legs(tags: left & right)
/// 3. State: to fulfill components with their configuration. DNA. TODO
public struct EntityConfig: TextRepresentable {
    let taggedComponents: [(component: Component, tags: [String])]
    let name: String
}

open class Environment {

    // MARK: Lifespan

    deinit {
        systems.forEach {
            $0.detach()
        }
    }

    public init(systems: [System]) {
        self.systems = systems
        self.queue = DispatchQueue(label: "org.taknada.environment")
        
        systems.forEach {
            $0.attach(to: self)
        }
    }

    // MARK: Entities

    open func make(config: EntityConfig) -> Entity {
        let entity = EntityImpl(
            name: config.name,
            guid: guidGenerator.getNextGuid(),
            taggedComponents: config.taggedComponents,
            environment: self)
        entities.insert(entity)
        return Entity(ref: entity)
    }

    // MARK: Components

    open func registerComponent(component: Component) {
        systems.forEach { $0.register(component: component) }
    }

    open func unregisterComponent(component: Component) {
        systems.forEach { $0.unregister(component: component) }
    }

    // MARK: Message Dispatching

    open func dispatch(message: TextRepresentable, to entity: Entity) {
        if message is KillMessage {
            guard let ref = entity.ref else { return }
            entities.remove(ref)
            return
        }

        entity.receive(message: message)
    }

    // MARK: URL Namespace

    /// You may query entity by guid, registered domain zone, todo
    open func query(with url: URL) -> [Entity] {
        fatalError("TODO")
    }

    // MARK: Stuff

    private let queue: DispatchQueue
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
