import Foundation

public protocol Component: class {

    init()
    func register(entity: EntityRef)
    func unregister()
}

public protocol System: class {

    func register(component: Component)
    func unregister(component: Component)
}
