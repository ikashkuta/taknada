import Foundation

final class DispatchSystem: System<Dispatcher> {
	override func register(component: Dispatcher) {
		super.register(component)
	}

	override func unregister(component: Dispatcher) {
		super.unregister(component)
	}
	
	override func update() {
		// TODO: different modes
		// NOTE: works only inside of entity by default
	}
}
