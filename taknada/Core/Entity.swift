import Foundation

public struct Entity: TextRepresentable {

    // MARK: Lifespan

    init(ref: EntityImpl) {
        self.ref = ref
    }

    // MARK: Stuff

    weak var ref: EntityImpl?
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

    public var name: String {
        return read(key: ConventionKeys.Entity.name)!
    }

    public var guid: String {
        return read(key: ConventionKeys.Entity.guid)!
    }
}
