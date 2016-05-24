import Foundation
import UIKit

class Scene3: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let t1 = EntityFactory.makeText()

		t1.textData.text = "Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!"

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(t1.entity)
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
