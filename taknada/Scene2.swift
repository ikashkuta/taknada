import Foundation
import UIKit

class Scene2: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let e1 = EntityFactory.makeDraggable()
		let e2 = EntityFactory.makeDraggable()
		let e3 = EntityFactory.makeDraggable()

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(e1.entity)
		windowManager.addEntity(e2.entity)
		windowManager.addEntity(e3.entity)
	}
}

extension Scene2 {
	static func make(window: Entity) -> Entity {
		let script = Scene2()

		script.window = window

		let scene = Entity(name: String(Scene2.self), components: [script])
		return scene
	}
}
