import Foundation
import UIKit

class ScrollableScript: Script {
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

	final private func didScroll(offset: CGPoint) {
		// TODO: should be done via events. This behavior is only for attaching custom input behavior,
		// not updating transform.. or not?
		self.scrollLayout.data.localTransform = CGAffineTransformTranslate(self.scrollLayout.data.localTransform,
		                                                                   -offset.x,
		                                                                   -offset.y)
	}

	final private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
		weak var behavior: ScrollableScript!

		@objc
		func scrollViewDidScroll(scrollView: UIScrollView) {
			behavior.didScroll(scrollView.contentOffset)
			scrollView.contentOffset = CGPoint.zero
		}
	}
}
