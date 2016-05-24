import Foundation

// Entity is final on purpose: with this I force you to use components for any
// state that entity may have. Do not create wrapper classes, extensions at last.
final class Entity {

	// MARK: - Public API

	let guid: UInt

	// Since Entity is final class, which is done on purpose, I want to have some way to
	// distinguish entities during debug. And, at restoration time, this name will be needed
	// to find appropriate entity factory.
	let name: String

	func getComponent<ComponentType: Component>(tag: String? = nil) -> ComponentType {
		for component in self.components {
			if component is ComponentType {
				if let tag = tag where !component.tags.contains(tag) { continue }
				return component as! ComponentType
			}
		}
		assertionFailure("Entity \(self.name) doesn't contain component \(ComponentType.self)")
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

	func destroy() {
		self.components.forEach { $0.unregisterSelf() }
		Entity.entities.remove(self)
	}

	// MARK: - Init & Deinit

	init(name: String, components: [Component]) {
		self.name = name
		self.components = components
		self.guid = Entity.getNextGuid()
		self.components.forEach { $0.registerSelf(self) }
		Entity.entities.insert(self)
	}

	// MARK: - Private

	private let components: [Component]

	private static var guidFactory: UInt = 0

	private static func getNextGuid() -> UInt {
		// TODO: Not thread-safe :(
		let result = self.guidFactory
		self.guidFactory += 1
		return result
	}

	private static var entities = Set<Entity>()
}

func ==(lhs: Entity, rhs: Entity) -> Bool {
	return lhs === rhs
}

extension Entity: Hashable {
	var hashValue: Int {
		return self.guid.hashValue
	}
}
