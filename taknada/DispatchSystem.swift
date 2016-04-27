import Foundation

final class DispatchSystem: System<Worker> {
	override func register(component: Worker) {
		super.register(component)
		// TODO: Register component to receive all things it wants
	}

	override func unregister(component: Worker) {
		// TODO: Unregister component to receive all things it wants
		super.unregister(component)
	}
	
	override func update() {
		// TODO: different modes
		// TODO: works only inside of entity by default

		for script in self.components {
			if !script.isRunning {
				script.start()
			}
		}
	}
}
