import Foundation

internal final class EntityImpl {

    // MARK: Lifespan

    deinit {
        taggedComponents.forEach {
            environment.unregisterComponent(component: $0.component)
            $0.component.unregister()
        }
    }

    init(kind: String,
         guid: String,
         taggedComponents: [(component: Component, tags: [String])],
         environment: Environment) {
        self.storage["kind"] = kind
        self.storage["guid"] = guid
        self.taggedComponents = taggedComponents
        self.environment = environment

        let ref = Entity(ref: self)
        self.taggedComponents.forEach {
            $0.component.register(entity: ref)
            self.environment.registerComponent(component: $0.component)
        }
    }

    // MARK: Storage

    private var storage = [String: TextRepresentable]()
    private var observers = [String: [(TextRepresentable) -> Void]]()

    func write(key: String, data: TextRepresentable, persistent: Bool) {
        // TODO: persistence
        storage[key] = data
        observers[key]?.forEach { $0(data) }
    }

    func read(key: String) -> TextRepresentable? {
        return storage[key]
    }

    func observe(key: String, observer: @escaping (TextRepresentable) -> Void) {
        if observers[key] == nil {
            observers[key] = []
        }
        observers[key]?.append(observer)
    }

    // MARK: Messages

    private var connections = [Entity]()

    func addConnection(with entity: Entity) {
        connections.append(entity)
    }

    func removeConnection(with entity: Entity) {
        guard let ref = entity.ref else { return }
        guard let idx = connections.index(where: { $0.ref == ref }) else { return }
        connections.remove(at: idx)
    }

    func post(message: TextRepresentable) {
        receive(message: message)
        connections.forEach {
            // TODO: cleanup empty refs, expecially remote ones
            environment.dispatch(message: message, to: $0)
        }
    }

    func receive(message: TextRepresentable) {
        taggedComponents.forEach {
            guard let receiver = $0.component as? MessageReceiver else { return }
            receiver.receive(message: message)
        }
    }

    // MAKR: Components

    private let taggedComponents: [(component: Component, tags: [String])]

    func getComponents<T>(_ tag: String? = nil) -> [T] {
        var result = [T]()
        for (component, tags) in taggedComponents {
            guard component is T else { continue }
            if let tag = tag, !tags.contains(tag) { continue }
            result.append(component as! T)
        }
        return result
    }

    func getComponent<T>(_ tag: String? = nil) -> T {
        let result: T? = getComponents(tag).first
        if result == nil {
            // TODO: Really? I think better to notify about error and go ahead
            assertionFailure("Entity \(self) doesn't contain component \(T.self)")
        }
        return result!
    }

    // MARK: Stuff

    private unowned let environment: Environment
}

extension EntityImpl: Equatable {

    static func ==(lhs: EntityImpl, rhs: EntityImpl) -> Bool {
        return lhs === rhs
    }
}

extension EntityImpl: Hashable {

    var hashValue: Int {
        return Unmanaged.passUnretained(self).toOpaque().hashValue
    }
}
