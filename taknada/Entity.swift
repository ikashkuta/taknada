import Foundation

final class Entity {

	// MARK: - Public API

	let guid: UInt

	func getComponent<ComponentType: Component>(tag: String?) -> ComponentType {
		for component in self.components {
			if component is ComponentType {
				if let tag = tag where !component.tags.contains(tag) { continue }
				return component as! ComponentType
			}
		}
		assertionFailure("Entity \(self) doesn't contain component \(ComponentType.self)")
		return Component() as! ComponentType
	}

	func getComponents<ComponentType: Component>(tag: String?) -> [ComponentType] {
		var result = [ComponentType]()
		for component in self.components {
			if component is ComponentType {
				if let tag = tag where !component.tags.contains(tag) { continue }
				result.append(component as! ComponentType)
			}
		}
		return result
	}

	// MARK: - Init & Deinit

	init(components: [Component]) {
		self.components = components
		self.guid = Entity.getNextGuid()
		self.components.forEach { $0.registerSelf(self) }
	}

	deinit {
		self.components.forEach { $0.unregisterSelf() }
	}

	// MARK: - Private

	private let components: [Component]
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
