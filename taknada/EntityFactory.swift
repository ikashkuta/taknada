import Foundation
import UIKit

final class EntityFactory {

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let layout = Layout(tags: [ConventionTags.mainLayout])
		let layoutData = LayoutDataStorage()
		let dispatcher = Manager()

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		layoutData.boundingBox = CGSize(width: 100, height: 200)

		layout.data = layoutData

		let entity = Entity(name: "Simple",
		                    components: [render, renderData, layout, layoutData, baseRenderUpdateScript, dispatcher])

		// TODO: moreover, all data (not only this) configuratoin should have been done outside of factory
		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let layout = Layout(tags: [ConventionTags.mainLayout])
		let layoutData = LayoutDataStorage()
		let input = DraggableInput()
		let dispatcher = Manager()

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

	static func makeText() -> (entity: Entity, render: Render, layout: Layout, textData: TextDataStorage) {
		let render = TextRender(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let layout = TextLayout(tags: [ConventionTags.mainLayout])
		let baseLayoutData = LayoutDataStorage()
		let textData = TextDataStorage()
		let dispatcher = WindowManager()

		let baseRenderUpdateScript = RenderUpdateScript()
		let textRenderUpdateScript = TextRenderUpdateScript()

		textRenderUpdateScript.textRender = render
		textRenderUpdateScript.textData = textData

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		layout.data = baseLayoutData
		layout.textData = textData

		render.textData = textData

		let entity = Entity(name: "Text",
		                    components: [render, renderData, layout, baseLayoutData, textData, baseRenderUpdateScript, textRenderUpdateScript, dispatcher])

		renderData.borderWidth = 1 // TODO: moreover, all data (not only this) configuratoin should have been done outside of factory
		
		return (entity, render, layout, textData)
	}
}
