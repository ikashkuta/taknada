import Foundation

public struct Entity: TextRepresentable {

    // MARK: Lifespan

    internal init(ref: EntityImpl) {
        self.ref = ref
    }

    // MARK: Stuff

    internal weak var ref: EntityImpl?
    internal let isLocal: Bool = true
}

// MARK: Storage
extension Entity {

    public func write(key: String, data: TextRepresentable, persistent: Bool) {
        ref?.write(key: key, data: data, persistent: persistent)
    }

    public func read<T: TextRepresentable>(key: String) -> T? {
        return ref?.read(key: key) as? T
    }

    func observe<T: TextRepresentable>(key: String, observer: @escaping (T) -> Void) {
        ref?.observe(key: key) { newValue in
            //TODO: let typedValue = newValue as? T ?? T(newValue)
            let typedValue = newValue as! T
            observer(typedValue)
        }
    }
}

// MARK: Messages
extension Entity {

    public func receive(message: TextRepresentable) { // incoming messages
        ref?.receive(message: message)
    }

    public func post(message: TextRepresentable) { // outgoing messages
        ref?.post(message: message)
    }
}

// MARK: Convenience vars
extension Entity {

    public var kind: String {
        return read(key: ConventionKeys.Entity.kind)!
    }

    public var guid: String {
        return read(key: ConventionKeys.Entity.guid)!
    }
}
