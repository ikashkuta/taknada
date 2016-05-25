import Foundation
import UIKit

final class WindowManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

	/// `entity` should have ConventionTags.mainLayout layout
	func addEntity(entity: Entity) {
		// TODO: probably, this manager should lister to changes in entity storage and do
		// things accordingly. Will be much easier later when persistence come.
		self.entityStorage.add(entity)
		ConventionTags.Basic.getMainLayout(entity).parent = self.layout
	}

	func removeEntity(entity: Entity) {
		ConventionTags.Basic.getMainLayout(entity).parent = nil
		self.entityStorage.remove(entity)
		entity.destroy()
	}

	// MARK: - Private

	private var layout: Layout {
		return self.getSibling(ConventionTags.Basic.mainLayout)
	}
}
