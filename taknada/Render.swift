import Foundation
import UIKit

class Render: Component {

	// MARK: - Public API

	struct ViewHasBecomeAliveFact: Fact {
		let source: String
	}

	final var inputs: [Input]?

	final var view: UIView?

	final private(set) var children = [Render]()

	final var parent: Render? {
		willSet {
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self }  // TODO: soooo bad :(
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}

	final func commitUpdate(update: () -> Void) {
		SystemLocator.renderSystem?.applyUpdateCommit({ [weak self] in
			if self != nil {
				update()
			}
		})
	}

	final func updateFrame(globalFrame: CGRect) {
		self.commitUpdate {
			var relativeFrame = CGRectIntegral(globalFrame)
			if let parent = self.parent {
				relativeFrame = SystemLocator.renderSystem!.convert(globalFrame: globalFrame, toRelativeToRender: parent)
			}
			self.view?.frame = relativeFrame
		}
	}

	final func updateBackgroundColor(color: UIColor) {
		self.commitUpdate {
			self.view?.backgroundColor = color
		}
	}

	final func updateBorderColor(color: UIColor) {
		self.commitUpdate {
			self.view?.layer.borderColor = color.CGColor
		}
	}

	final func updateBorderWidth(width: CGFloat) {
		self.commitUpdate {
			self.view?.layer.borderWidth = width
		}
	}

	final func updateCornerRadius(radius: CGFloat) {
		self.commitUpdate {
			self.view?.layer.cornerRadius = radius
		}
	}

	final func updateView(alive alive: Bool) {
		let shouldCreate = (self.view == nil) && alive
		let shouldDestroy = (self.view != nil) && !alive

		let maybeUpdate: (() -> Void)?
		if shouldCreate {
			maybeUpdate = {
				if self.view != nil { return }
				self.initView()
				self.dispatcher.report(ViewHasBecomeAliveFact(source: #function))
			}
		} else if shouldDestroy {
			maybeUpdate = {
				if self.view == nil { return }
				self.deinitView()
			}
		} else {
			maybeUpdate = nil
		}

		if let update = maybeUpdate {
			self.commitUpdate(update)
		}
	}

	// MARK: - To Override

	func createView() -> UIView {
		return UIView()
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	override func unregisterSelf() {
		if self.view != nil {
			self.deinitView()
		}
		self.inputs = nil
		self.parent = nil
		SystemLocator.renderSystem?.unregister(self)
	}

	// MARK: - Private

	private func initView() {
		self.view = self.createView()
		self.parent!.view!.addSubview(self.view!)
		self.attachInputs()
	}

	private func deinitView() {
		self.detachInputs()
		self.view!.removeFromSuperview()
		self.view = nil
	}

	private func attachInputs() {
		self.inputs?.forEach{ $0.attach() }
	}

	private func detachInputs() {
		self.inputs?.forEach{ $0.detach() }
	}
}
