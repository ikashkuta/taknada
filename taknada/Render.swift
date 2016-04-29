import Foundation
import UIKit

class Render: Component {

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
	var styles: [Style]? // TODO: I don't like this, too many double-linked components
	var inputs: [Input]? // TODO: I don't like this, too many double-linked components

	final var view: UIView?
	func createView() -> UIView {
		return UIView.init()
	}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.layout = nil
		self.styles = nil
		SystemLocator.renderSystem?.unregister(self)
	}
}
