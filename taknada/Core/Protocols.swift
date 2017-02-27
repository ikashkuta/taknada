import Foundation

struct ConventionKeys {
    struct Entity {
        static let name = "name"
        static let guid = "guid"
    }
}

struct KillMessage: TextRepresentable {} // TODO: move to other place

public protocol MessageReceiver {

    func receive(message: TextRepresentable)
}

public protocol Component: class {

    init()
    func attach(to entity: Entity)
    func detach()
}

public protocol System: class {

    func register(component: Component)
    func unregister(component: Component)
}
