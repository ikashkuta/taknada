import Foundation
import UIKit

final class EntityFactory {
	static func makeWindow(mainView: UIView) -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
		let layoutData = LayoutDataStorage()
		let dispatcher = Dispatcher()

		let layoutToRenderSyncScript = LayoutToRenderSyncScript()

		layoutData.boundingBox = mainView.frame.size
		
		layout.data = layoutData

		render.basicData = renderData
		render.view = mainView
		render.layout = layout

		let window = Entity(components: [layout, layoutData, render, renderData, layoutToRenderSyncScript, dispatcher])
		return (window, render, layout)
	}

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
		let layoutData = LayoutDataStorage()
		let dispatcher = Dispatcher()

		let layoutToRenderSyncScript = LayoutToRenderSyncScript()

		layoutData.boundingBox = CGSize(width: 100, height: 200)

		layout.data = layoutData

		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		render.basicData = renderData
		render.layout = layout

		let entity = Entity(components: [render, renderData, layout, layoutData, layoutToRenderSyncScript, dispatcher])
		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let layout = Layout()
		let layoutData = LayoutDataStorage()
		let input = DraggableInput()
		let dispatcher = Dispatcher()

		let layoutToRenderSyncScript = LayoutToRenderSyncScript()

		input.render = render
		input.layoutData = layoutData

		layoutData.boundingBox = CGSize(width: 100, height: 100)

		layout.data = layoutData

		renderData.backgroundColor = UIColor.purpleColor()
		renderData.borderWidth = 3
		renderData.borderColor = UIColor.blueColor()
		renderData.cornerRadius = 10

		render.basicData = renderData
		render.layout = layout
		render.inputs = [input]

		let entity = Entity(components: [render, renderData, layout, layoutData, input, layoutToRenderSyncScript, dispatcher])
		return (entity, render, layout)
	}

	static func makeScrollable() -> (entity: Entity, render: Render, scrollLayout: Layout) {
		let render = Render()
		let renderData = RenderDataStorage()
		let baseLayout = Layout()
		let baseLayoutData = LayoutDataStorage()
		let scrollLayout = Layout()
		let scrollLayoutData = LayoutDataStorage()
		let input = ScrollableInput()
		let dispatcher = Dispatcher()

		let layoutToRenderSyncScript = LayoutToRenderSyncScript()

		input.render = render
		input.scrollLayoutData = scrollLayoutData

		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayoutData.boundingBox = CGSize(width: 400, height: 400)

		baseLayout.data = baseLayoutData

		renderData.borderWidth = 1

		render.basicData = renderData
		render.layout = baseLayout
		render.inputs = [input]

		let entity = Entity(components: [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, layoutToRenderSyncScript, dispatcher])
		return (entity, render, scrollLayout)
	}
}
