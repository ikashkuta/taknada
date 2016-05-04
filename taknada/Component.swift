import Foundation

class Component {
	let tags: [String]

	init(tags: [String] = []) {
		self.tags = tags
	}

	final private weak var entity: Entity!
	final func registerSelf(entity: Entity) {
		self.entity = entity
		self.registerSelf()
	}

	// MARK: - Public API

	final func getSibling<ComponentType: Component>(siblingTag: String? = nil) -> ComponentType {
		return self.entity.getComponent(siblingTag)
	}

	final func getSiblings<ComponentType: Component>(siblingsTag: String? = nil) -> [ComponentType] {
		return self.entity.getComponents(siblingsTag)
	}

	// MARK: - To Subclass

	func registerSelf() {
	}

	func unregisterSelf() {
	}

}
