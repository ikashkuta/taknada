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

	override func unregister(component: Render) {
		if let view = component.view {
			self.detachInputs(component)
			view.removeFromSuperview()
			component.view = nil
		}
		component.parent = nil
		super.unregister(component)
	}

	override func update() {
		// TODO: add visible components
		self.update(self.window)
		// TODO: remove invisible components, detach inputs from them
	}

	// MARK: - Private

	private var window: Render

	private func update(render: Render) {
		self.updateView(render)
		render.children.forEach { self.update($0) }
	}

	// TODO: Move to explicit update action, part of culling project
	// TODO: View updates could be done only after creating a view
	// moreover, they should be redone after view's recreating
	private func updateView(render: Render) {
		if render.view == nil {
			render.view = render.createView()
			render.parent!.view!.addSubview(render.view!)
			self.attachInputs(render)
		}
	}

	private func attachInputs(render: Render) {
		render.inputs?.forEach{ $0.attach() }
	}

	private func detachInputs(render: Render) {
		render.inputs?.forEach{ $0.detach() }
	}
}
