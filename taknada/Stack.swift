import Foundation

import CoreGraphics // TODO: remove

extension Entity {
	static func makeStack() -> Entity {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage()
		let baseLayout = Layout(tags: [ConventionTags.mainLayout])
		let baseLayoutData = LayoutDataStorage()
		let scrollLayout = StackLayout(tags: [ConventionTags.Stack.scrollLayout])
		let scrollLayoutData = LayoutDataStorage()
		let input = ScrollableInput()
		let entityStorate = EntityStorage()
		let manager = StackManager(tags: [ConventionTags.mainManager])

		manager.entityStorage = entityStorate

		let baseRenderUpdateScript = RenderUpdateScript()

		baseRenderUpdateScript.data = renderData
		baseRenderUpdateScript.render = render
		baseRenderUpdateScript.layout = baseLayout

		input.render = render
		input.scrollLayoutData = scrollLayoutData

		scrollLayoutData.boundingBox = CGSize(width: 200, height: 200) // TODO: Should be dynamic

		scrollLayout.direction = .vertical
		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayout.data = baseLayoutData

		render.inputs = [input]

		let components = [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, baseRenderUpdateScript, entityStorate, manager]
		let entity = Entity(name: "Stack", components: components)

		// TODO: this configuratoin should be done outside of factory
		renderData.borderWidth = 1
		baseLayoutData.boundingBox = CGSize(width: 400, height: 400)
		
		return entity
	}
}
