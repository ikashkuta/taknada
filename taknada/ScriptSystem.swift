import Foundation

final class ScriptSystem: System<Manager> {

	// MARK: - Init

	override init(queue: dispatch_queue_t) {
		super.init(queue: queue)
	}

	// MARK: - System

	override func register(component: Manager) {
		super.register(component)
		dispatch_set_target_queue(component.dispatchQueue, self.queue)
	}

	override func unregister(component: Manager) {
		super.unregister(component)
	}
}
