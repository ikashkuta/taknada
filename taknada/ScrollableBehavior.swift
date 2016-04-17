import Foundation
import UIKit

// TODO: should be done via events
class ScrollableBehavior: Behavior {
	var render: Render!
	var scrollLayout: Layout!

	override func unregisterSelf() {
		self.render = nil
		self.scrollLayout = nil
	}

	override func attach() {
		self.scrollView = UIScrollView.init()
		self.scrollView!.contentSize = CGSize(width: 1000, height: 1000)
		self.scrollView!.delegate = self.scrollViewDelegate
		self.render.view?.addGestureRecognizer(self.scrollView!.panGestureRecognizer)
		self.scrollViewDelegate.behavior = self
	}

	private var scrollView: UIScrollView?
	private var scrollViewDelegate = ScrollViewDelegate()

	private func didScroll(offset: CGPoint) {
		self.scrollLayout.localTransform = CGAffineTransformTranslate(self.scrollLayout.localTransform,
		                                                              -offset.x,
		                                                              -offset.y)
	}

	private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
		weak var behavior: ScrollableBehavior!

		@objc
		func scrollViewDidScroll(scrollView: UIScrollView) {
			behavior.didScroll(scrollView.contentOffset)
			scrollView.contentOffset = CGPoint.zero
		}
	}
}
