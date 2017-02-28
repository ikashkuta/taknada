import Foundation
import UIKit

public class UIKitSystem: System {

    // MARK: Lifespan

    public init(window: UIView) {
        self.window = window
        self.queue = DispatchQueue(
            label: "org.taknada.uikitsystem",
            target: DispatchQueue.main)
    }

    // MARK: System

    public func attach(to environment: Environment) {
    }

    public func detach() {
    }

    public func register(component: Component) {
        guard let uiComponent = component as? UIKitComponent else { return }
        components.insert(uiComponent)
    }

    public func unregister(component: Component) {
        guard let uiComponent = component as? UIKitComponent else { return }
        components.remove(uiComponent)
    }

    // MARK: Stuff

    private let window: UIView
    private let queue: DispatchQueue
    private var components = Set<UIKitComponent>()

    // TODO: it's completely wrong :(
    func needUpdate() {
        queue.async { [weak self] in
            guard let sSelf = self else { return }
            for component in sSelf.components {
                let view = component.createView()
                component.view = view
                sSelf.window.addSubview(view)
            }
        }
    }
}
