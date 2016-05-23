import Foundation

// Entity is final on purpose: with this I force you to use components for any
// state that entity may have. Do not create wrapper classes, extensions at last.
final class Entity {

	// MARK: - Public API

	let guid: UInt

	// Since Entity is final class, which is done on purpose, I want to have some way to
	// distinguish entities during debug.
	let name: String

	func getComponent<ComponentType: Component>(tag: String? = nil) -> ComponentType {
		for component in self.components {
			if component is ComponentType {
				if let tag = tag where !component.tags.contains(tag) { continue }
				return component as! ComponentType
			}
		}
		assertionFailure("Entity \(self) doesn't contain component \(ComponentType.self)")
		return Component() as! ComponentType
	}

	func getComponents<ComponentType: Component>(tag: String? = nil) -> [ComponentType] {
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

	init(name: String, components: [Component]) {
		self.name = name
		self.components = components
		self.guid = Entity.getNextGuid()
		self.components.forEach { $0.registerSelf(self) }
	}

	deinit {
		self.components.forEach { $0.unregisterSelf() }
	}

	// MARK: - Private

	private let components: [Component]

	static private var guidFactory: UInt = 0

	static private func getNextGuid() -> UInt {
		// TODO: Not thread-safe :(
		let result = self.guidFactory
		self.guidFactory += 1
		return result
	}
}
