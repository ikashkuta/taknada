import Foundation
import UIKit

final class EntityFactory {
	static func makeWindow(mainView: UIView) -> (entity: Entity, render: Render, layout: Layout) {
		let render = Render()
		let layout = Layout()

		layout.data.boundingBox = mainView.frame.size

		render.view = mainView
		render.layout = layout

		let window = Entity(components: [layout, render])
		return (window, render, layout)
	}

	static func makeSimple() -> (entity: Entity, render: Render, layout: Layout) {
		let render = MapRender()
		let layout = Layout()
		let style = Style()

		style.backgroundColor = UIColor.purpleColor()
		style.borderWidth = 3
		style.borderColor = UIColor.blueColor()
		style.cornerRadius = 10

		layout.data.boundingBox = CGSize(width: 100, height: 200)

		render.layout = layout
		render.styles = [style]

		let entity = Entity(components: [render, layout, style])
		return (entity, render, layout)
	}

	static func makeDraggable() -> Entity {
		let render = Render()
		let layout = Layout()
		let style = Style()
		let script = DraggableScript()

		script.render = render
		script.layout = layout

		style.backgroundColor = UIColor.purpleColor()
		style.borderWidth = 3
		style.borderColor = UIColor.blueColor()
		style.cornerRadius = 10

		layout.data.boundingBox = CGSize(width: 100, height: 100)

		render.layout = layout
		render.styles = [style]

		let entity = Entity(components: [render, layout, style, script])
		return entity

	}

	static func makeScrollable() -> (entity: Entity, render: Render, scrollLayout: Layout) {
		let render = Render()
		let baseLayout = Layout()
		let scrollLayout = Layout()
		let style = Style()
		let script = ScrollableScript()

		script.render = render
		script.scrollLayout = scrollLayout

		style.borderWidth = 1

		scrollLayout.parent = baseLayout

		baseLayout.data.boundingBox = CGSize(width: 400, height: 400)

		render.layout = baseLayout
		render.styles = [style]

		let entity = Entity(components: [render, baseLayout, scrollLayout, style, script])
		return (entity, render, scrollLayout)
	}
}
