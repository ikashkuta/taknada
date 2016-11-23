import Foundation
import UIKit

class RenderComponent: Component {

	// MARK: API

	final var view: UIView?

	// MARK: To Override

	func createView() -> UIView {
		return UIView()
	}

	// MARK: Ancestry

	 required init() {

	}

	func register(entity: EntityRef) {
		// TODO: subscribe to corner radius, border colour, border width, frame, colour, etc.. Call to super is mandatory!
	}

	func unregister() {
		// TODO: unregister of everything. Call to super is mandatory!
	}
}

extension RenderComponent: Equatable {

	public static func ==(lhs: RenderComponent, rhs: RenderComponent) -> Bool {
		return lhs === rhs
	}
}

extension RenderComponent: Hashable {

	public var hashValue: Int {
		return ObjectIdentifier(self).hashValue
	}
}
