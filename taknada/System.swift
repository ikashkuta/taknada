import Foundation

class System<ComponentType: Component> {

	// MARK: - Public API

	private(set) var components = [ComponentType]()

	// MARK: - To Override

	func register(component: ComponentType) {
		self.components.append(component)
	}

	func unregister(component: ComponentType) {
		self.components = self.components.filter { $0 !== component }
	}

	func update() {
	}
}
