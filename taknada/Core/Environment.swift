import Foundation

struct KillMessage: TextRepresentable {}

open class Environment {

    // MARK: Lifespan

    public init(systems: [System]) {
        self.systems = systems
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

    open func make() -> Entity {
        let entity = EntityImpl(kind: "", guid: guidGenerator.getNextGuid(), components: [], environment: self)
        return Entity(ref: entity)
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
