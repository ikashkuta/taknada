import Foundation
import UIKit

final class EntityFactory {

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(tags: [ConventionTags.Basic.mainRender])
		let renderData = RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
		let layout = Layout(tags: [ConventionTags.Basic.mainLayout])
		let layoutData = LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
		let dispatcher = Manager(tags: [ConventionTags.Basic.mainManager])

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		layoutData.boundingBox = CGSize(width: 100, height: 200)

		layout.data = layoutData

		let components = [render, renderData, layout, layoutData, baseRenderUpdateScript, dispatcher]
		let entity = Entity(name: "Simple", components: components)

		// TODO: moreover, all data (not only this) configuratoin should have been done outside of factory
		ConventionTags.Basic.getMainRenderData(entity).backgroundColor = UIColor.purpleColor()
		ConventionTags.Basic.getMainRenderData(entity).borderWidth = 3
		ConventionTags.Basic.getMainRenderData(entity).borderColor = UIColor.blueColor()
		ConventionTags.Basic.getMainRenderData(entity).cornerRadius = 10

		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(tags: [ConventionTags.Basic.mainRender])
		let renderData = RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
		let layout = Layout(tags: [ConventionTags.Basic.mainLayout])
		let layoutData = LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
		let input = DraggableInput()
		let dispatcher = Manager(tags: [ConventionTags.Basic.mainManager])

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		input.render = render
		input.layoutData = layoutData

		layoutData.boundingBox = CGSize(width: 100, height: 100)

		layout.data = layoutData

		render.inputs = [input]

		let entity = Entity(name: "SimpleDraggable",
		                    components: [render, renderData, layout, layoutData, input, baseRenderUpdateScript, dispatcher])

		// TODO: moreover, all data (not only this) configuratoin should have been done outside of factory
		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		return (entity, render, layout)
	}
}
