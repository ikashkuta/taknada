import Foundation
import UIKit

class Render: Component {

	// MARK: - Public API

	final var data: RenderDataStorage!

	var layout: Layout!
	var inputs: [Input]? // TODO: I don't like this, too many double-linked components

	final var view: UIView?

	// MARK: - To Subclass

	func createView() -> UIView {
		return UIView.init()
	}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.layout = nil
		SystemLocator.renderSystem?.unregister(self)
	}

	// MARK: - Private

	// MARK: -- Update

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

	// MARK: -- Tree

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
}
