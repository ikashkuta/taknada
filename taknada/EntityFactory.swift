import Foundation
import UIKit

final class EntityFactory {
	static func makeWindow(mainView: UIView) -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let layout = Layout()
		let dispatcher = Dispatcher()

		layout.data.boundingBox = mainView.frame.size

		render.view = mainView
		render.layout = layout

		let window = Entity(components: [layout, render, dispatcher])
		return (window, render, layout)
	}

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let layout = Layout()
		let dispatcher = Dispatcher()

		layout.data.boundingBox = CGSize(width: 100, height: 200)

		render.data.backgroundColor = UIColor.purpleColor()
		render.data.borderWidth = 3
		render.data.borderColor = UIColor.blueColor()
		render.data.cornerRadius = 10
		render.layout = layout

		let entity = Entity(components: [render, layout, dispatcher])
		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let renderWorker = RenderWorker()
		let layout = Layout()
		let input = DraggableInput()
		let dispatcher = Dispatcher()

		input.render = render
		input.layout = layout

		layout.data.boundingBox = CGSize(width: 100, height: 100)

		render.data.backgroundColor = UIColor.purpleColor()
		render.data.borderWidth = 3
		render.data.borderColor = UIColor.blueColor()
		render.data.cornerRadius = 10
		render.layout = layout
		render.inputs = [input]

		let entity = Entity(components: [render, layout, input, dispatcher, renderWorker])
		return (entity, render, layout)
	}

	static func makeScrollable() -> (entity: Entity, render: Render, scrollLayout: Layout) {
		let render = Render()
		let baseLayout = Layout()
		let scrollLayout = Layout()
		let input = ScrollableInput()
		let dispatcher = Dispatcher()

		input.render = render
		input.scrollLayout = scrollLayout

		scrollLayout.parent = baseLayout

		baseLayout.data.boundingBox = CGSize(width: 400, height: 400)

		render.data.borderWidth = 1
		render.layout = baseLayout
		render.inputs = [input]

		let entity = Entity(components: [render, baseLayout, scrollLayout, input, dispatcher])
		return (entity, render, scrollLayout)
	}
}
