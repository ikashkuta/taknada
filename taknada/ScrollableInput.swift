import Foundation
import UIKit

class ScrollableInput: Input {

	// MARK: - Public API

	var render: Render!
	var scrollLayoutData: LayoutDataStorage!

	// MARK: - Component

	override func unregisterSelf() {
		self.render = nil
		self.scrollLayoutData = nil
		super.unregisterSelf()
	}

	// MARK: - Input

	override func attach() {
		self.scrollView = UIScrollView.init()
		self.scrollView.directionalLockEnabled = true // TODO: extract to data storage
		self.scrollView.contentSize = CGSize(width: 1000, height: 1000)
		self.scrollView.delegate = self.scrollViewDelegate
		self.render.view?.addGestureRecognizer(self.scrollView.panGestureRecognizer)
		self.render.view?.userInteractionEnabled = true
	}

	override func detach() {
		self.render.view?.userInteractionEnabled = false
		self.render.view?.removeGestureRecognizer(self.scrollView.panGestureRecognizer)
		self.scrollView = nil
	}

	// MARK: - Private

	private var scrollView: UIScrollView!
	private lazy var scrollViewDelegate: ScrollViewDelegate = {
		return ScrollViewDelegate(input: self)
	}()

	final private func didScroll(offset: CGPoint) {
		self.scrollLayoutData.localTransform = CGAffineTransformTranslate(self.scrollLayoutData.localTransform,
		                                                                  -offset.x,
		                                                                  -offset.y)
	}

	final private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
		unowned let input: ScrollableInput
		init(input: ScrollableInput) {
			self.input = input
		}

		@objc
		func scrollViewDidScroll(scrollView: UIScrollView) {
			self.input.didScroll(scrollView.contentOffset)
			scrollView.contentOffset = CGPoint.zero
		}
	}
}
