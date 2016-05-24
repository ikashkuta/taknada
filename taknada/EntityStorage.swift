import Foundation

final class EntityStorage: DataStorage {

    // MARK: - Public API

	func add(entity: Entity) {
		self.entities.insert(entity)
	}

	func remove(entity: Entity) {
		self.entities.remove(entity)
	}

    // MARK: - Private

	private var entities = Set<Entity>()
}
