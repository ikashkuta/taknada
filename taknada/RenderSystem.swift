import Foundation
import UIKit

final class RenderSystem: System<Render> {

	// MARK: - Init & Deinit

	init(window: Render, queue: dispatch_queue_t) {
		self.window = window
		super.init(queue: queue)
		self.register(self.window)
	}

	func applyUpdateCommit(updateAction: () -> Void) {
		dispatch_async(self.queue) { 
			updateAction()
		}
	}

	func convert(globalFrame globalFrame: CGRect, toRelativeToRender render: Render) -> CGRect {
		return self.window.view!.convertRect(globalFrame, toView: render.view!)
	}

	// MARK: - System

	override func register(component: Render) {
		super.register(component)
		guard component !== self.window else { return }
		component.parent = self.window
	}

	// MARK: - Private

	private var window: Render
}
