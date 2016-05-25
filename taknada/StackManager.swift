import Foundation

final class StackManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

	/// `entity` should have ConventionTags.mainLayout layout & ConventionTags.mainRender render
	func addEntity(entity: Entity) {
		self.entityStorage.add(entity)
		ConventionTags.Basic.getMainLayout(entity).parent = self.scrollLayout
		ConventionTags.Basic.getMainRender(entity).parent = self.render
	}

	func removeEntity(entity: Entity) {
		ConventionTags.Basic.getMainRender(entity).parent = nil
		ConventionTags.Basic.getMainLayout(entity).parent = nil
		self.entityStorage.remove(entity)
		entity.destroy()
	}

	// MARK: - Private

	private var scrollLayout: Layout {
		return self.getSibling(ConventionTags.Stack.scrollLayout)
	}

	private var render: Render {
		return self.getSibling(ConventionTags.Basic.mainRender)
	}
}
