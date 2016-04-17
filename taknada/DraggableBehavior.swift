import Foundation
import UIKit

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
	final private func handleGesture(recognizer: UIPanGestureRecognizer) {
		// TODO: should be done via events. This behavior is only for attaching custom input behavior,
		// not updating transform.. or not? Input must be handled on same thread and fire appropriate events,
		// then logic behavior should handle this and update transform.
		let translation = recognizer.translationInView(recognizer.view)
		recognizer.setTranslation(CGPoint.zero, inView: recognizer.view)
		self.layout.localTransform = CGAffineTransformTranslate(self.layout.localTransform,
		                                                        translation.x,
		                                                        translation.y)
	}
}
