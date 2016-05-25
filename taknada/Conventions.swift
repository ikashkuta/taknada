import Foundation

protocol ComponentName { }

struct ConventionTags {
	struct Basic {

		static let mainRender = "MainRender"

		static func getMainRender(entity: Entity) -> Render {
			return entity.getComponent(ConventionTags.Basic.mainRender)
		}


		static let mainLayout = "MainLayout"

		static func getMainLayout(entity: Entity) -> Layout {
			return entity.getComponent(ConventionTags.Basic.mainLayout)
		}


		static let mainManager = "MainManager"

		static func getMainManager(entity: Entity) -> Manager {
			return entity.getComponent(ConventionTags.Basic.mainManager)
		}


		static let mainRenderData = "mainRenderData"

		static func getMainRenderData(entity: Entity) -> RenderDataStorage {
			return entity.getComponent(ConventionTags.Basic.mainRenderData)
		}


		static let mainLayoutData = "mainLayoutData"

		static func getMainLayoutData(entity: Entity) -> LayoutDataStorage {
			return entity.getComponent(ConventionTags.Basic.mainLayoutData)
		}
	}
}
