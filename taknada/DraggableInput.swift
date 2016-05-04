import Foundation
import UIKit

class DraggableInput: Input {

	// MARK: - Public API

	var render: Render!
	var layout: Layout!

	// MARK: - Component

	override func unregisterSelf() {
		self.render = nil
		self.layout = nil
		super.unregisterSelf()
	}

	// MARK: - Input

	override func detach() {
		self.render.view?.removeGestureRecognizer(self.panRecognizer)
	}

	override func attach() {
		self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableInput.handleGesture))
		self.render.view?.addGestureRecognizer(self.panRecognizer)
	}

	// MARK: - Private

	private var panRecognizer: UIPanGestureRecognizer!

	@objc
	final private func handleGesture(recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translationInView(recognizer.view)
		recognizer.setTranslation(CGPoint.zero, inView: recognizer.view)
		self.layout.data.localTransform = CGAffineTransformTranslate(self.layout.data.localTransform,
		                                                             translation.x,
		                                                             translation.y)
	}
}
