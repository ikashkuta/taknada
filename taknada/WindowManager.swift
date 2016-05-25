import Foundation
import UIKit

final class WindowManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

	/// `entity` should have ConventionTags.mainLayout layout
	func addEntity(entity: Entity) {
		self.entityStorage.add(entity)
		let layoutOfEntity: Layout = entity.getComponent(ConventionTags.mainLayout)
		layoutOfEntity.parent = self.layout
	}

	func removeEntity(entity: Entity) {
		let layoutOfEntity: Layout = entity.getComponent(ConventionTags.mainLayout)
		layoutOfEntity.parent = nil
		self.entityStorage.remove(entity)
		entity.destroy()
	}

	// MARK: - Private

	private var layout: Layout {
		return self.getSibling(ConventionTags.mainLayout)
	}
}
