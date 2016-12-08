import Foundation
import UIKit

public class UIKitSystem: System {

    // MARK: Lifespan

    public init(window: UIView, queue: DispatchQueue) {
        self.window = window
        self.queue = queue
    }

    // MARK: Ancestry

    public func register(component: Component) {
        guard let render = component as? UIKitComponent else { return }
        components.insert(render)
    }

    public func unregister(component: Component) {
        guard let render = component as? UIKitComponent else { return }
        components.remove(render)
    }

    // MARK: Stuff

    private let window: UIView
    private let queue: DispatchQueue
    private var components = Set<UIKitComponent>()

    // TODO: it's completely wrong :(
    func needUpdate() {
        for component in components {
            let view = component.createView()
            component.view = view
            self.window.addSubview(view)
        }
    }
}
