import Foundation

extension ConventionTags {
	static let scrollLayout
		= "ScrollLayout"
}

final class StackManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

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
		return self.getSibling(ConventionTags.scrollLayout)
	}

	private var render: Render {
		return self.getSibling(ConventionTags.mainRender)
	}
}

import CoreGraphics // TODO: remove

extension StackManager {
	static func make() -> Entity {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let baseLayout = Layout(tags: [ConventionTags.mainLayout])
		let baseLayoutData = LayoutDataStorage()
		let scrollLayout = StackLayout(tags: [ConventionTags.scrollLayout])
		let scrollLayoutData = LayoutDataStorage()
		let input = ScrollableInput()
		let entityStorate = EntityStorage()
		let manager = StackManager(tags: [ConventionTags.mainManager])

		manager.entityStorage = entityStorate

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = baseLayout

		input.render = render
		input.scrollLayoutData = scrollLayoutData

		scrollLayoutData.boundingBox = CGSize(width: 200, height: 200) // TODO: Should be dynamic

		scrollLayout.direction = .vertical
		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayout.data = baseLayoutData

		render.inputs = [input]

		let components = [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, baseRenderUpdateScript, entityStorate, manager]
		let entity = Entity(name: String(StackManager.self), components: components)

		// TODO: this configuratoin should be done outside of factory
		renderData.borderWidth = 1
		baseLayoutData.boundingBox = CGSize(width: 400, height: 400)

		return entity
	}
}
