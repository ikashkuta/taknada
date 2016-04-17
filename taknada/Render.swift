import Foundation
import UIKit

/** @abstract
This component must be stateless in terms of abilty to regenerate this object
fully from inner state of other components. There is no need of smth like "virtual dom"
because changes in UIKit are non-atomic (comparing to ones in browser).
More concrete: "Stateless" means this component doesn't own it's layout, colour, border properties,
control state, frame, bounds, position. Nothing. It might contain this information (because of UIKit's
requirements) but it mustn't own it.
*/
class Render: Component {
	override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	override func unregisterSelf() {
		SystemLocator.renderSystem?.unregister(self)
		self.layout = nil
		self.styles = nil
		self.behaviors = nil
	}

	private(set) var children = [Render]()
	var parent: Render? {
		willSet {
			// TODO: it must be appropriate datastructure, not Array
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
	var behaviors: [Behavior]? // TODO: I don't like this, too many double-linked components

	var view: UIView?
	func createView() -> UIView {
		return UIView.init()
	}
}
