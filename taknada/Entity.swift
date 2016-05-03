import Foundation

class Entity {
	let components: [Component]

	init(components: [Component]) {
		self.components = components
		self.components.forEach { $0.registerSelf(self) }
	}

	deinit {
		self.components.forEach { $0.unregisterSelf() }
	}

	final func getComponent<ComponentType: Component>(componentName: String?) -> ComponentType {
		for component in self.components {
			if component is ComponentType {
				if let name = componentName where component.name != name {
					continue
				}
				return component as! ComponentType
			}
		}
		assertionFailure("Entity \(self) doesn't contain component \(ComponentType.self)")
		return Component(name: "generic_name") as! ComponentType
	}

	final func getComponents<ComponentType: Component>() -> [ComponentType] {
		var result = [ComponentType]()
		for component in self.components {
			if component is ComponentType {
				result.append(component as! ComponentType)
			}
		}
		return result
	}
}
