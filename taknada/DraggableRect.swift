import Foundation

extension Entity {
	struct DraggableRect {
		static func make() -> Entity {
			let render
				= Render(tags: [ConventionTags.Basic.mainRender])
			let renderData
				= RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
			let layout
				= Layout(tags: [ConventionTags.Basic.mainLayout])
			let layoutData
				= LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
			let input
				= DraggableInput()
			let dispatcher
				= Manager(tags: [ConventionTags.Basic.mainManager])
			let baseRenderUpdateScript
				= RenderUpdateScript()

			baseRenderUpdateScript.data = renderData
			baseRenderUpdateScript.render = render
			baseRenderUpdateScript.layout = layout

			input.render = render
			input.layoutData = layoutData

			layout.data = layoutData

			render.inputs = [input]

			let components = [render, renderData, layout, layoutData, input, baseRenderUpdateScript, dispatcher]
			return Entity(name: "DraggableRect", components: components)
		}
	}
}
