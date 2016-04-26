import Foundation

final class DispatchSystem: System {
	private var components = [Script]()

	func register(component: Script) {
		self.components.append(component)
	}

	func unregister(component: Script) {
		self.components = self.components.filter { $0 !== component }
	}
	
	func update() {
		// TODO: different modes
		// TODO: works only inside of entity by default
		// TODO: events (actions in terms of redux) must be typed

		for script in self.components {
			if !script.isRunning {
				script.start()
			}
		}
	}
}

