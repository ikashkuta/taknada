import Foundation

final class LayoutSystem: System<Layout> {
	private var window: Layout

	init(window: Layout) {
		self.window = window
		super.init()
		self.register(self.window)
	}

	override func register(component: Layout) {
		super.register(component)
		guard component !== self.window else { return }
		component.parent = self.window
	}

	override func unregister(component: Layout) {
		component.parent = nil
		super.unregister(component)
	}

	override func update() {
		// TODO: Bad traversal. Should be linear tree traversal. Related to parent-child implementation in components.
		for layout in self.components {
			if layout.needsUpdate {
				layout.updateGlobalFrame()
			}
		}
	}
}
