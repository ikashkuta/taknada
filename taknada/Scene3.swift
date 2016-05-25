import Foundation
import UIKit

class Scene3: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let text = Entity.Text.make()

		let textRenderData: RenderDataStorage = text.getComponent(ConventionTags.Basic.mainRenderData)
		textRenderData.borderWidth = 1

		let textData: TextDataStorage = text.getComponent(ConventionTags.Text.mainTextData)
		textData.text = "Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!"

		let windowManager: WindowManager = window.getComponent(ConventionTags.Basic.mainManager)
		windowManager.addEntity(text)
	}
}

extension Scene3 {
	static func make(window: Entity) -> Entity {
		let script = Scene3()

		script.window = window

		let scene = Entity(name: String(Scene3), components: [script])
		return scene
	}
}
