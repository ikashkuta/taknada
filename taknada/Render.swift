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
	var scripts: [Script]? // TODO: I don't like this, too many double-linked components

	final var view: UIView?
	func createView() -> UIView {
		return UIView.init()
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	override func unregisterSelf() {
		SystemLocator.renderSystem?.unregister(self)
		self.layout = nil
		self.styles = nil
		self.scripts = nil
	}
}


// TODO: But how to know that layout or style changes?..
// Also, it seems that it reasonable to track layout & style changes separately
final class RenderData {
	private(set) var version: UInt = 0
	let guid = "render_guid_uniq-num-per-instance"
	var layout: Layout
	var styles: [Style]
	init(layout: Layout, styles: [Style]) {
		self.layout = layout
		self.styles = styles
	}
}
