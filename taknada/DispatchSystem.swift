import Foundation

final class DispatchSystem: System<Dispatcher> {

	// MARK: - Init

	override init(queue: dispatch_queue_t) {
		super.init(queue: queue)
	}

	// MARK: - System

	override func register(component: Dispatcher) {
		super.register(component)
		dispatch_set_target_queue(component.dispatchQueue, self.queue)
	}

	override func unregister(component: Dispatcher) {
		super.unregister(component)
	}
}
