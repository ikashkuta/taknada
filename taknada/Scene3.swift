import Foundation
import UIKit

class Scene3: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let text = Entity.Text.make()

		ConventionTags.Basic.getMainRenderData(text).borderWidth = 1
		ConventionTags.Text.getMainTextData(text).text = "Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!"

		ConventionTags.Window.getManager(window).addEntity(text)
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
