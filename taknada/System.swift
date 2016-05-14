import Foundation

class System<ComponentType: Component> {

	// MARK: - Public API

	private(set) var components = [ComponentType]()
	
	let queue: dispatch_queue_t

	final func setNeedsUpdate() {
		if self.waitsForUpdate { return }

		// TODO: it's fine for now, but later, with Update List it shouldn't be like this.
		self.waitsForUpdate = true
		dispatch_async(self.queue) {
			self.waitsForUpdate = false
			self.update()
		}
	}

	// MARK: - To Override

	func register(component: ComponentType) {
		self.components.append(component)
	}

	func unregister(component: ComponentType) {
		self.components = self.components.filter { $0 !== component }
	}

	func update() {
	}

	// MARK: - Init

	init(queue: dispatch_queue_t) {
		self.queue = queue
	}

	// MARK: - Private

	private var waitsForUpdate: Bool = false
}
