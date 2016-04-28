import Foundation


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
