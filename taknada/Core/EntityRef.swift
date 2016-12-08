import Foundation

public struct EntityRef {

    // MARK: Lifespan

    internal init(ref: EntityImpl) {
        self.ref = ref
    }

    // MARK: Stuff

    internal weak var ref: EntityImpl?
    internal let isLocal: Bool = true
}

extension EntityRef: TextRepresentable {
}

extension EntityRef { // Minidb

    public func write(key: String, data: TextRepresentable, persistent: Bool) {
        ref?.write(key: key, data: data, persistent: persistent)
    }

    public func read<T: TextRepresentable>(key: String) -> T? {
        return ref?.read(key: key) as? T
    }

    public func subscribe(key: String) -> Observable<TextRepresentable>? {
        return ref?.subscribe(key: key)
    }
}

extension EntityRef { // Messages

    public func receive(message: TextRepresentable) { // incoming messages
        ref?.receive(message: message)
    }

    public func post(message: TextRepresentable) { // outgoing messages
        ref?.post(message: message)
    }
}

extension EntityRef { // Convenience vars

    public var kind: String {
        return read(key: "kind")!
    }

    public var guid: String {
        return read(key: "guid")!
    }
}
