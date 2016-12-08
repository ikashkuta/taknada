import Foundation

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
