import Foundation
import UIKit

final class RenderSystem: System<Render> {

	// MARK: - Init & Deinit

	init(window: Render) {
		self.window = window
		super.init()
		self.register(self.window)
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
		if render.needsUpdate { render.update() } // Only style for now
		self.updateFrame(render)
		render.children.forEach { self.update($0) }
	}

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

	private func updateFrame(render: Render) {
		var globalFrame = render.layout.globalFrame
		if let parent = render.parent {
			globalFrame = self.window.view!.convertRect(globalFrame, toView: parent.view!)
		}
		render.view!.frame = globalFrame
	}
}
