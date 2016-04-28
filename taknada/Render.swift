import Foundation
import UIKit

/** @abstract
This component must be stateless in terms of abilty to regenerate this object
fully from inner state of other components. There is no need of smth like "virtual dom"
because changes in UIKit are non-atomic (comparing to ones in browser).
More concrete: "Stateless" means this component doesn't own it's layout, colour, border properties,
control state, frame, bounds, position. Nothing. It might contain this information (because of UIKit's
requirements) but it mustn't own it. Actually, all components must follow this guidelines.
*/
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
