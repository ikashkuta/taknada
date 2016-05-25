import Foundation

extension Entity {
	struct SimpleRect {
		static func make() -> Entity {
			let render
				= Render(tags: [ConventionTags.Basic.mainRender])
			let renderData
				= RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
			let layout
				= Layout(tags: [ConventionTags.Basic.mainLayout])
			let layoutData
				= LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
			let dispatcher
				= Manager(tags: [ConventionTags.Basic.mainManager])
			let baseRenderUpdateScript
				= RenderUpdateScript()

			baseRenderUpdateScript.data = renderData
			baseRenderUpdateScript.render = render
			baseRenderUpdateScript.layout = layout

			layout.data = layoutData

			let components = [render, renderData, layout, layoutData, baseRenderUpdateScript, dispatcher]
			return Entity(name: "SimpleRect", components: components)
		}
	}
}
