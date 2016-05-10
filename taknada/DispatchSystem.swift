import Foundation

final class DispatchSystem: System<Dispatcher> {

	// MARK: - Init

	override init(queue: dispatch_queue_t) {
		super.init(queue: queue)
	}

	// MARK: - System

	override func register(component: Dispatcher) {
		super.register(component)
	}

	override func unregister(component: Dispatcher) {
		super.unregister(component)
	}
	
	override func update() {
		// TODO: different modes, all this must be lazy using system runloops
		self.components.forEach {
			$0.processSending()
		}
	}
}
