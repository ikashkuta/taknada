import Foundation

extension ConventionTags {
	struct Text {
		static let mainTextData	= "mainTextData"

		static func getMainTextData(entity: Entity) -> TextDataStorage {
			return entity.getComponent(ConventionTags.Text.mainTextData)
		}
	}
}

extension Entity {
	struct Text {
		static func make() -> Entity {
			let render
				= TextRender(tags: [ConventionTags.Basic.mainRender])
			let renderData
				= RenderDataStorage(tags: [ConventionTags.Basic.mainRenderData])
			let layout
				= TextLayout(tags: [ConventionTags.Basic.mainLayout])
			let baseLayoutData
				= LayoutDataStorage(tags: [ConventionTags.Basic.mainLayoutData])
			let textData
				= TextDataStorage(tags: [ConventionTags.Text.mainTextData])
			let dispatcher
				= WindowManager()

			let baseRenderUpdateScript = RenderUpdateScript()
			let textRenderUpdateScript = TextRenderUpdateScript()

			textRenderUpdateScript.textRender = render
			textRenderUpdateScript.textData = textData

			baseRenderUpdateScript.data = renderData
			baseRenderUpdateScript.render = render
			baseRenderUpdateScript.layout = layout

			layout.data = baseLayoutData
			layout.textData = textData

			render.textData = textData

			let components = [render, renderData, layout, baseLayoutData, textData, baseRenderUpdateScript, textRenderUpdateScript, dispatcher]
			return Entity(name: "Text", components: components)
		}
	}
}
