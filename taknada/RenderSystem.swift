import Foundation
import UIKit

public class RenderSystem: System {

	// MARK: Lifespan

	public init(window: UIView, queue: DispatchQueue) {
		self.window = window
		self.queue = queue
	}

	// MARK: Ancestry

	public func register(component: Component) {
		guard let render = component as? RenderComponent else { return }
		self.components.insert(render)
	}

	public func unregister(component: Component) {
		guard let render = component as? RenderComponent else { return }
		self.components.remove(render)
	}

	// MARK: Stuff

	private let window: UIView
	private let queue: DispatchQueue
	private var components = Set<RenderComponent>()
}
