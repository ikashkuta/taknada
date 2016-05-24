import Foundation
import UIKit

final class WindowManager: Manager {

	// MARK: - Public API

	var entityStorage: EntityStorage!

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
		let mainLayout: Layout = self.getSibling(ConventionTags.mainLayout)
		return mainLayout
	}
}

extension WindowManager {
	static func make(window: UIView) -> Entity {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let layout = Layout(tags: [ConventionTags.mainLayout])
		let layoutData = LayoutDataStorage()
		let entityStorage = EntityStorage()
		let manager = WindowManager(tags: [ConventionTags.mainManager])

		manager.entityStorage = entityStorage

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		layoutData.boundingBox = window.frame.size

		layout.data = layoutData

		render.view = window

		let components = [layout, layoutData, render, renderData, baseRenderUpdateScript, entityStorage, manager]
		let window = Entity(name: "Window", components: components)
		return window
	}
}
