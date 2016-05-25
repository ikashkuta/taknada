import Foundation

extension ConventionTags {
	struct Stack {
		static let scrollLayout = "ScrollLayout"

		static func getScrollLayout(entity: Entity) -> Layout {
			return entity.getComponent(self.scrollLayout)
		}


		static let manager = "StackManager"

		static func getManager(entity: Entity) -> StackManager {
			return entity.getComponent(self.manager)
		}
	}
}

extension Entity {
	struct Stack {
		static func make() -> Entity {
			let render
				= Render(tags: [ConventionTags.Basic.mainRender])
			let renderData
				= RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
			let baseLayout
				= Layout(tags: [ConventionTags.Basic.mainLayout])
			let baseLayoutData
				= LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
			let scrollLayout
				= StackLayout(tags: [ConventionTags.Stack.scrollLayout])
			let scrollLayoutData
				= LayoutDataStorage()
			let input
				= ScrollableInput()
			let entityStorate
				= EntityStorage()
			let manager
				= StackManager(tags: [ConventionTags.Basic.mainManager, ConventionTags.Stack.manager])

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
			return Entity(name: "Stack", components: components)
		}
	}
}
