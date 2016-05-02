import Foundation

final class DispatchSystem: System<Dispatcher> {
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
