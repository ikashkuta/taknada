import Foundation

internal final class Entity {

    // MARK: Lifespan

    deinit {
        self.components.forEach {
            self.environment.unregisterComponent(component: $0.component)
            $0.component.unregister()
        }
    }

    init(kind: String,
         guid: String,
         components: [Component.Type],
         environment: Environment) {
        self.environment = environment
        self.components = components.map { ($0.init(), []) }

        self.storage["kind"] = kind
        self.storage["guid"] = guid

        let ref = EntityRef(ref: self)
        self.components.forEach {
            $0.component.register(entity: ref)
            self.environment.registerComponent(component: $0.component)
        }
    }

    // MARK: Storage

    var storage = [String: TextRepresentable]()

    func write(key: String, data: TextRepresentable, persistent: Bool) {
        // TODO: persistence
        self.storage[key] = data
    }

    func read(key: String) -> TextRepresentable? {
        return self.storage[key]
    }

    func subscribe(key: String) -> Observable<TextRepresentable> {
        fatalError("TODO")
    }

    // MARK: Messages

    private var connections = [EntityRef]()

    func addConnection(with entity: EntityRef) {
        self.connections.append(entity)
    }

    func removeConnection(with entity: EntityRef) {
        guard let ref = entity.ref else { return }
        guard let idx = self.connections.index(where: { $0.ref == ref }) else { return }
        self.connections.remove(at: idx)
    }

    func post(message: TextRepresentable) {
        self.receive(message: message)
        self.connections.forEach {
            // TODO: cleanup empty refs, expecially remote ones
            self.environment.dispatch(message: message, to: $0)
        }
    }

    func receive(message: TextRepresentable) {
        self.components.forEach {
            guard let receiver = $0 as? MessageReceiver else { return }
            receiver.receive(message: message)
        }
    }

    // MAKR: Components

    private let components: [(component: Component, tags: [String])]

    func getComponents<T>(_ tag: String? = nil) -> [T] {
        var result = [T]()
        for (component, tags) in self.components {
            guard component is T else { continue }
            if let tag = tag, !tags.contains(tag) { continue }
            result.append(component as! T)
        }
        return result
    }

    func getComponent<T>(_ tag: String? = nil) -> T {
        let result: T? = self.getComponents(tag).first
        if result == nil {
            // TODO: Really? I think better to notify about error and go ahead
            assertionFailure("Entity \(self) doesn't contain component \(T.self)")
        }
        return result!
    }

    // MARK: Stuff

    private unowned let environment: Environment
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
