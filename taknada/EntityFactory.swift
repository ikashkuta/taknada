import Foundation
import UIKit

final class EntityFactory {

	static func makeWindow(mainView: UIView) -> Entity {
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
		let layoutData = LayoutDataStorage()
		let dispatcher = Dispatcher()

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = layout

		layoutData.boundingBox = mainView.frame.size

		layout.data = layoutData

		render.view = mainView

		let window = Entity(name: "Window",
		                    components: [layout, layoutData, render, renderData, baseRenderUpdateScript, dispatcher])
		return window
	}

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
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
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
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

	static func makeScrollable() -> (entity: Entity, render: Render, baseLayout: Layout, scrollLayout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let baseLayout = Layout(tags: [ConventionTags.mainLayout])
		let baseLayoutData = LayoutDataStorage()
		let scrollLayout = StackLayout()
		let scrollLayoutData = LayoutDataStorage()
		let input = ScrollableInput()
		let dispatcher = Manager()

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = baseLayout

		input.render = render
		input.scrollLayoutData = scrollLayoutData

		scrollLayoutData.boundingBox = CGSize(width: 200, height: 200)

		scrollLayout.direction = .vertical
		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayoutData.boundingBox = CGSize(width: 400, height: 400)

		baseLayout.data = baseLayoutData

		render.inputs = [input]

		let entity = Entity(name: "SimpleScrollable",
		                    components: [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, baseRenderUpdateScript, dispatcher])

		renderData.borderWidth = 1 // TODO: moreover, all data (not only this) configuratoin should have been done outside of factory

		return (entity, render, baseLayout, scrollLayout)
	}

	static func makeText() -> (entity: Entity, render: Render, layout: Layout, textData: TextDataStorage) {
		let render = TextRender()
		let renderData = RenderDataStorage()
		let layout = TextLayout()
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

		let entity = Entity(name: "Test",
		                    components: [render, renderData, layout, baseLayoutData, textData, baseRenderUpdateScript, textRenderUpdateScript, dispatcher])

		renderData.borderWidth = 1 // TODO: moreover, all data (not only this) configuratoin should have been done outside of factory
		
		return (entity, render, layout, textData)
	}
}
