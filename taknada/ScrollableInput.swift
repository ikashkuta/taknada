import Foundation
import UIKit

class ScrollableInput: Input {

	// MARK: - Public API

	var render: Render!
	var scrollLayout: Layout!

	struct DidScrollFact: Fact {
		var source: String
		var newTranslation: (CGFloat, CGFloat)
	}

	// MARK: - Component

	override func unregisterSelf() {
		self.render = nil
		self.scrollLayout = nil
		super.unregisterSelf()
	}

	// MARK: - Input

	override func detach() {
		self.render.view?.removeGestureRecognizer(self.scrollView.panGestureRecognizer)
		self.scrollView = nil
	}

	override func attach() {
		self.scrollView = UIScrollView.init()
		self.scrollView.directionalLockEnabled = true
		self.scrollView.contentSize = CGSize(width: 1000, height: 1000)
		self.scrollView.delegate = self.scrollViewDelegate
		self.render.view?.addGestureRecognizer(self.scrollView.panGestureRecognizer)
	}

	// MARK: - Private

	private var scrollView: UIScrollView!
	private lazy var scrollViewDelegate: ScrollViewDelegate = {
		return ScrollViewDelegate(input: self)
	}()

	final private func didScroll(offset: CGPoint) {
		self.scrollLayout.data.localTransform = CGAffineTransformTranslate(self.scrollLayout.data.localTransform,
		                                                                   -offset.x,
		                                                                   -offset.y)

		let dispatcher: Dispatcher = self.getSibling()
		let newTranslation = (self.scrollLayout.data.localTransform.tx, self.scrollLayout.data.localTransform.ty)
		dispatcher.sendMessage(DidScrollFact(source: #function, newTranslation: newTranslation))
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
