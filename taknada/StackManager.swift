import Foundation

extension ConventionTags {
	struct Stack {
		static let scrollLayout
			= "ScrollLayout"
	}
}

final class StackManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

	/// `entity` should have ConventionTags.mainLayout layout & ConventionTags.mainRender render
	func addEntity(entity: Entity) {
		self.entityStorage.add(entity)

		let layout: Layout = entity.getComponent(ConventionTags.mainLayout)
		layout.parent = self.scrollLayout

		let render: Render = entity.getComponent(ConventionTags.mainRender)
		render.parent = self.render
	}

	func removeEntity(entity: Entity) {
		let render: Render = entity.getComponent(ConventionTags.mainRender)
		render.parent = nil

		let layout: Layout = entity.getComponent(ConventionTags.mainLayout)
		layout.parent = nil

		self.entityStorage.remove(entity)
		entity.destroy()
	}

	// MARK: - Private

	private var scrollLayout: Layout {
		return self.getSibling(ConventionTags.Stack.scrollLayout)
	}

	private var render: Render {
		return self.getSibling(ConventionTags.mainRender)
	}
}
