import Foundation
import UIKit

final class EntityFactory {
	static func makeWindow(mainView: UIView) -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(name: "render")
		let renderData = RenderDataStorage(name: "renderData")
		let layout = Layout(name: "layout")
		let layoutData = LayoutDataStorage(name: "layoutData")
		let dispatcher = Dispatcher(name: "dispatcher")

		layoutData.boundingBox = mainView.frame.size
		
		layout.data = layoutData

		render.data = renderData
		render.view = mainView
		render.layout = layout

		let window = Entity(components: [layout, layoutData, render, renderData, dispatcher])
		return (window, render, layout)
	}

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(name: "render")
		let renderData = RenderDataStorage(name: "renderData")
		let layout = Layout(name: "layout")
		let layoutData = LayoutDataStorage(name: "layoutData")
		let dispatcher = Dispatcher(name: "dispatcher")

		layoutData.boundingBox = CGSize(width: 100, height: 200)

		layout.data = layoutData

		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		render.data = renderData
		render.layout = layout

		let entity = Entity(components: [render, renderData, layout, layoutData, dispatcher])
		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render(name: "render")
		let renderData = RenderDataStorage(name: "renderData")
		let renderWorker = RenderWorker(name: "baseRenderWorker")
		let layout = Layout(name: "layout")
		let layoutData = LayoutDataStorage(name: "layoutData")
		let input = DraggableInput(name: "dragInput")
		let dispatcher = Dispatcher(name: "dispatcher")

		input.render = render
		input.layout = layout

		layoutData.boundingBox = CGSize(width: 100, height: 100)

		layout.data = layoutData

		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		render.data = renderData
		render.layout = layout
		render.inputs = [input]

		let entity = Entity(components: [render, renderData, layout, layoutData, input, dispatcher, renderWorker])
		return (entity, render, layout)
	}

	static func makeScrollable() -> (entity: Entity, render: Render, scrollLayout: Layout) {
		let render = Render(name: "render")
		let renderData = RenderDataStorage(name: "renderData")
		let baseLayout = Layout(name: "baseLayout")
		let baseLayoutData = LayoutDataStorage(name: "baseLayoutData")
		let scrollLayout = Layout(name: "scrollLayout")
		let scrollLayoutData = LayoutDataStorage(name: "scrollLayoutData")
		let input = ScrollableInput(name: "scrollInput")
		let dispatcher = Dispatcher(name: "dispatcher")

		input.render = render
		input.scrollLayout = scrollLayout

		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayoutData.boundingBox = CGSize(width: 400, height: 400)

		baseLayout.data = baseLayoutData

		renderData.borderWidth = 1

		render.data = renderData
		render.layout = baseLayout
		render.inputs = [input]

		let entity = Entity(components: [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, dispatcher])
		return (entity, render, scrollLayout)
	}
}
