import Foundation

final class Entity {
	let guid: UInt

	init(components: [Component]) {
		self.components = components
		self.guid = Entity.getNextGuid()
		self.components.forEach { $0.registerSelf(self) }
	}

	deinit {
		self.components.forEach { $0.unregisterSelf() }
	}

	private let components: [Component]

	func getComponent<ComponentType: Component>(componentName: String?) -> ComponentType {
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

	func getComponents<ComponentType: Component>() -> [ComponentType] {
		var result = [ComponentType]()
		for component in self.components {
			if component is ComponentType {
				result.append(component as! ComponentType)
			}
		}
		return result
	}
}

// MARK: - Guids

extension Entity {
	static private var guidFactory: UInt = 0
	static private func getNextGuid() -> UInt {
		let result = self.guidFactory
		self.guidFactory += 1
		return result
	}
}
