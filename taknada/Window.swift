import Foundation
import UIKit

extension ConventionTags {
	struct Window {
		static let manager = "WindowManager"

		static func getManager(entity: Entity) -> WindowManager {
			return entity.getComponent(self.manager)
		}
	}
}

extension Entity {
	struct Window {
		static func make(window: UIView) -> Entity {
			let render = Render(tags: [ConventionTags.Basic.mainRender])
			let renderData = RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
			let layout = Layout(tags: [ConventionTags.Basic.mainLayout])
			let layoutData = LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
			let entityStorage = EntityStorage()
			let manager = WindowManager(tags: [ConventionTags.Basic.mainManager, ConventionTags.Window.manager])

			manager.entityStorage = entityStorage

			let baseRenderUpdateScript = RenderUpdateScript()

			baseRenderUpdateScript.data = renderData
			baseRenderUpdateScript.render = render
			baseRenderUpdateScript.layout = layout

			layoutData.boundingBox = window.frame.size

			layout.data = layoutData

			render.view = window

			let components = [layout, layoutData, render, renderData, baseRenderUpdateScript, entityStorage, manager]
			return Entity(name: "Window", components: components)
		}
	}
}
