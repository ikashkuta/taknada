import Foundation
import UIKit

extension Entity {
	static func makeWindow(window: UIView) -> Entity {
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
