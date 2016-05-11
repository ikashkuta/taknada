import Foundation

final class LayoutSystem: System<Layout> {

	// MARK: - Init & Deinit

	init(window: Layout, queue: dispatch_queue_t) {
		self.window = window
		super.init(queue: queue)
		self.register(self.window)
	}

	// MARK: - System

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
		// TODO: Very bad traversal. Should be linear tree traversal. Related to parent-child implementation in components.
		for layout in self.components {
			if layout.needsUpdate {
				layout.update()
			}
		}
	}

	// MARK: - Private

	private var window: Layout

}
