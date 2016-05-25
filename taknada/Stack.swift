import Foundation

extension Entity {
	static func makeStack() -> Entity {
		let render = Render(tags: [ConventionTags.mainRender])
		let renderData = RenderDataStorage(tags: [ConventionTags.mainRenderData])
		let baseLayout = Layout(tags: [ConventionTags.mainLayout])
		let baseLayoutData = LayoutDataStorage(tags: [ConventionTags.mainLayoutData])
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

		scrollLayout.direction = .vertical
		scrollLayout.data = scrollLayoutData
		scrollLayout.parent = baseLayout

		baseLayout.data = baseLayoutData

		render.inputs = [input]

		let components = [render, renderData, baseLayout, baseLayoutData, scrollLayout, scrollLayoutData, input, baseRenderUpdateScript, entityStorate, manager]
		let entity = Entity(name: "Stack", components: components)
		
		return entity
	}
}
