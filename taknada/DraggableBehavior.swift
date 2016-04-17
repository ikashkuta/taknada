import Foundation
import UIKit

// TODO: should be done via events
class DraggableBehavior: Behavior {
	var render: Render!
	var layout: Layout!

	override func unregisterSelf() {
		self.render = nil
		self.layout = nil
	}

	override func attach() {
		let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableBehavior.handleGesture))
		self.render.view?.addGestureRecognizer(panRecognizer)
	}

	@objc
	func handleGesture(recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translationInView(recognizer.view)
		recognizer.setTranslation(CGPoint.zero, inView: recognizer.view)
		self.layout.localTransform = CGAffineTransformTranslate(self.layout.localTransform,
		                                                        translation.x,
		                                                        translation.y)
	}
}
