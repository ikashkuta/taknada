import Foundation

struct ConventionKeys {
    struct Entity {
        static let kind = "kind"
        static let guid = "guid"
    }
}

struct KillMessage: TextRepresentable {} // TODO: move to other place

public protocol MessageReceiver {

    func receive(message: TextRepresentable)
}

public protocol Component: class {

    init()
    func register(entity: Entity)
    func unregister()
}

public protocol System: class {

    func register(component: Component)
    func unregister(component: Component)
}
