import Foundation

final class LayoutSystem: System<Layout> {

	// MARK: - Public API

	func setNeedsUpdate() {
		if self.waitsForUpdate { return }
		self.waitsForUpdate = true
		dispatch_async(self.queue) {
			self.waitsForUpdate = false
			self.update(self.window)
		}
	}

	// MARK: - Init & Deinit

	init(window: Layout, queue: dispatch_queue_t) {
		self.window = window
		super.init(queue: queue)
		self.register(self.window)
	}

	// MARK: - Private

	private var window: Layout

	private var waitsForUpdate: Bool = false

	// TODO: Very bad traversal. Should be completely other way.
	private func update(layout: Layout) {
		if layout.needsUpdate {
			layout.update()
		}

		for layout in layout.children {
			self.update(layout)
		}
	}
}
