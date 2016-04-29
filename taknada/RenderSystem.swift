import Foundation
import UIKit

final class RenderSystem: System<Render> {
	private var window: Render

	init(window: Render) {
		self.window = window
		super.init()
		self.register(self.window)
	}

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

	private func update(render: Render) {
		self.updateView(render)
		self.updateStyles(render)
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

	private func updateStyles(render: Render) {
		render.styles?.forEach{ $0.styleView(render.view!) }
	}

	private func updateFrame(render: Render) {
		var globalFrame = render.layout.globalFrame
		if let parent = render.parent {
			globalFrame = self.window.view!.convertRect(globalFrame, toView: parent.view!)
		}
		render.view!.frame = globalFrame
	}
}

extension Style {
	// TODO: Very bad, General Render Script should take udpated computed data by itself after been notified by dispatcher
	// TODO: Same with layout
	func styleView(view: UIView) {
		view.backgroundColor = self.data.backgroundColor
		view.layer.borderColor = self.data.borderColor?.CGColor
		view.layer.borderWidth = self.data.borderWidth
		view.layer.cornerRadius = self.data.cornerRadius
	}
}
