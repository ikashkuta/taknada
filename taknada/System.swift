import Foundation

class System<ComponentType: Component> {
	private(set) var components = [ComponentType]()

	func register(component: ComponentType) {
		self.components.append(component)
	}

	func unregister(component: ComponentType) {
		self.components = self.components.filter { $0 !== component }
	}

	func update() {
	}
}
