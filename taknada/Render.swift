import Foundation
import UIKit

class Render: Component, Restorable {

	let data = RenderData()

	// MARK: - Tree

	// TODO: it must be appropriate datastructure for this tree, not Array
	final private(set) var children = [Render]()
	final var parent: Render? {
		willSet {
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self }
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}

	var layout: Layout!
	var inputs: [Input]? // TODO: I don't like this, too many double-linked components

	final var view: UIView?
	func createView() -> UIView {
		return UIView.init()
	}

	// MARK: - Update

	final private var lastUsedDataVersion = UInt.max
	final var needsUpdate: Bool {
		return self.data.version != self.lastUsedDataVersion
	}
	final func update() {
		self.view!.backgroundColor = self.data.backgroundColor
		self.view!.layer.borderColor = self.data.borderColor.CGColor
		self.view!.layer.borderWidth = self.data.borderWidth
		self.view!.layer.cornerRadius = self.data.cornerRadius
		self.lastUsedDataVersion = self.data.version
	}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.layout = nil
		SystemLocator.renderSystem?.unregister(self)
	}
}

final class RenderData: PersistentData {
	let name: String = "RenderData"
	let guid = "render_guid_uniq-num-per-instance"
	private(set) var version: UInt = 0

	var backgroundColor: UIColor = UIColor.whiteColor() {
		didSet {
			if oldValue != self.backgroundColor {
				self.version += 1
			}
		}
	}
	var borderColor: UIColor = UIColor.blackColor() {
		didSet {
			if oldValue != self.borderColor {
				self.version += 1
			}
		}
	}
	var borderWidth: CGFloat = 0 {
		didSet {
			if oldValue != self.borderWidth {
				self.version += 1
			}
		}
	}
	var cornerRadius: CGFloat = 0 {
		didSet {
			if oldValue != self.cornerRadius {
				self.version += 1
			}
		}
	}
}
