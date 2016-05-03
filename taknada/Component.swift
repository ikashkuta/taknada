import Foundation

class Component {
	//NOTE: may be different for compile time (entity, useful for editortime) and runtime (instance of entity)
	var guid: String = "guid_placeholder"

	//NOTE: some meaningful name, that makes sense for entity. "MainLayout", "ScrollableLayout", "ScrollableInput"
	let name: String

	init(name: String) {
		self.name = name
	}

	func registerSelf() {
	}

	func unregisterSelf() {
	}

	final private weak var entity: Entity!
	final func registerSelf(entity: Entity) {
		self.entity = entity
		self.registerSelf()
	}

	final func getSibling<ComponentType: Component>(siblingName: String? = nil) -> ComponentType {
		return self.entity.getComponent(siblingName)
	}

	final func getSiblings<ComponentType: Component>() -> [ComponentType] {
		return self.entity.getComponents()
	}
}
