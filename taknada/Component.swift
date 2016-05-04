import Foundation

// Rules:
// MARK: - Public API
// MARK: - To Subclass
// MARK: - Init & Deinit
// MARK: - BaseClass 1, 2,3
// MARK: - Private

class Component {

	// MARK: - Public API

	final let tags: [String]

	final func getSibling<ComponentType: Component>(siblingTag: String? = nil) -> ComponentType {
		return self.entity.getComponent(siblingTag)
	}

	final func getSiblings<ComponentType: Component>(siblingsTag: String? = nil) -> [ComponentType] {
		return self.entity.getComponents(siblingsTag)
	}

	// MARK: - Init & Deinit

	init(tags: [String] = []) {
		self.tags = tags
	}

	// MARK: - To Subclass

	func registerSelf() {
	}

	func unregisterSelf() {
	}

	// MARK: - Private
	
	final private weak var entity: Entity!
	final func registerSelf(entity: Entity) {
		self.entity = entity
		self.registerSelf()
	}
}
