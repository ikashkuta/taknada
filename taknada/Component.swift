import Foundation


/** @abstract
	All components must be stateless in terms of abilty to recalculate their state fully
	from inner state of other components and persistence date. There is no need of something
	like "virtual dom" because changes in UIKit are non-atomic (comparing to ones in the browsers).
	More concrete: "Stateless" means that component doesn't own it's layout, colour, border properties,
	control state, frame, bounds, network. Nothing. It might contain this information (because of UIKit's
	requirements) but it mustn't own it. All components must follow this guides.
*/
class Component {
	func registerSelf() {
	}

	func unregisterSelf() {
	}

	final private weak var entity: Entity!
	final func registerSelf(entity: Entity) {
		self.entity = entity
		self.registerSelf()
	}

	final func getSibling<ComponentType: Component>() -> ComponentType {
		return self.entity.getComponent()
	}

	final func getSiblings<ComponentType: Component>() -> [ComponentType] {
		return self.entity.getComponents()
	}
}
