import Foundation

class System<ComponentType: Component> {

	// MARK: - Public API

	private(set) var components = [ComponentType]()
	
	let queue: dispatch_queue_t

	// MARK: - To Override

	func register(component: ComponentType) {
		self.components.append(component)
	}

	func unregister(component: ComponentType) {
		self.components = self.components.filter { $0 !== component }
	}

	// MARK: - Init

	init(queue: dispatch_queue_t) {
		self.queue = queue
	}
}
