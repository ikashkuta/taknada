import Foundation
import UIKit

final class RenderSystem: System {
	private var window: Render
	private var components = [Render]()

	init(window: Render) {
		self.window = window
		self.register(self.window)
	}

	func register(component: Render) {
		self.components.append(component)
		guard component !== self.window else { return }
		component.parent = self.window
	}

	func unregister(component: Render) {
		if let view = component.view {
			view.removeFromSuperview()
			component.view = nil
		}
		component.parent = nil
		self.components = self.components.filter { $0 !== component }
	}

	func update() {
		// TODO: add visible components
		self.update(self.window)
		// TODO: remove invisible components
	}

	private func update(render: Render) {
		self.updateView(render)
		self.updateStyle(render)
		self.updateFrame(render)
		for child in render.children {
			self.update(child)
		}
	}

	private func updateView(render: Render) {
		if render.view == nil {
			render.view = render.createView()
			render.parent!.view!.addSubview(render.view!)
		}
	}

	private func updateStyle(render: Render) {
		guard let styles = render.styles else { return }
		for style in styles {
			style.styleView(render.view!)
		}
	}

	private func updateFrame(render: Render) {
		var globalFrame = render.layout.globalFrame
		if let parent = render.parent {
			globalFrame = self.window.view!.convertRect(globalFrame, toView: parent.view!)
		}
		render.view!.frame = globalFrame
	}
}
