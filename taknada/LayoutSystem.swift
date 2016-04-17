import Foundation

final class LayoutSystem: System {
	private var window: Layout
	private var components = [Layout]()

	init(window: Layout) {
		self.window = window
		self.register(self.window)
	}

	func register(component: Layout) {
		self.components.append(component)
		guard component !== self.window else { return }
		component.parent = self.window
	}

	func unregister(component: Layout) {
		component.parent = nil
		self.components = self.components.filter { $0 !== component }
	}

	func update() {
		// TODO: Bad traversal. Should be linear tree traversal
		for layout in self.components {
			if layout.needsUpdate {
				layout.updateState()
			}
		}
	}
}
