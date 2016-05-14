import Foundation
import UIKit

class Render: Component {

	// MARK: - Public API

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
			var relativeFrame = globalFrame
			if let parent = self.parent {
				relativeFrame = SystemLocator.renderSystem!.convert(globalFrame: globalFrame, toRelativeToRender: parent)
			}
			self.view!.frame = relativeFrame
		}
	}

	final func updateBackgroundColor(color: UIColor) {
		self.commitUpdate { 
			self.view!.backgroundColor = color
		}
	}

	final func updateBorderColor(color: UIColor) {
		self.commitUpdate {
			self.view!.layer.borderColor = color.CGColor
		}
	}

	final func updateBorderWidth(width: CGFloat) {
		self.commitUpdate {
			self.view!.layer.borderWidth = width
		}
	}

	final func updateCornerRadius(radius: CGFloat) {
		self.commitUpdate {
			self.view!.layer.cornerRadius = radius
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
		self.inputs = nil
		self.parent = nil
		SystemLocator.renderSystem?.unregister(self)
	}
}
