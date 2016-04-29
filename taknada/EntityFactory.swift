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
		let style = Style()
		let dispatcher = Dispatcher()

		style.data.backgroundColor = UIColor.purpleColor()
		style.data.borderWidth = 3
		style.data.borderColor = UIColor.blueColor()
		style.data.cornerRadius = 10

		layout.data.boundingBox = CGSize(width: 100, height: 200)

		render.layout = layout
		render.styles = [style]

		let entity = Entity(components: [render, layout, style, dispatcher])
		return (entity, render, layout)
	}

	static func makeDraggable() -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let layout = Layout()
		let style = Style()
		let input = DraggableInput()
		let dispatcher = Dispatcher()

		input.render = render
		input.layout = layout

		style.data.backgroundColor = UIColor.purpleColor()
		style.data.borderWidth = 3
		style.data.borderColor = UIColor.blueColor()
		style.data.cornerRadius = 10

		layout.data.boundingBox = CGSize(width: 100, height: 100)

		render.layout = layout
		render.styles = [style]
		render.inputs = [input]

		let entity = Entity(components: [render, layout, style, input, dispatcher])
		return (entity, render, layout)
	}

	static func makeScrollable() -> (entity: Entity, render: Render, scrollLayout: Layout) {
		let render = Render()
		let baseLayout = Layout()
		let scrollLayout = Layout()
		let style = Style()
		let input = ScrollableInput()
		let dispatcher = Dispatcher()

		input.render = render
		input.scrollLayout = scrollLayout

		style.data.borderWidth = 1

		scrollLayout.parent = baseLayout

		baseLayout.data.boundingBox = CGSize(width: 400, height: 400)

		render.layout = baseLayout
		render.styles = [style]
		render.inputs = [input]

		let entity = Entity(components: [render, baseLayout, scrollLayout, style, input, dispatcher])
		return (entity, render, scrollLayout)
	}
}
