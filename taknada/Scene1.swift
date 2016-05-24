import Foundation
import UIKit

class Scene1: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let e1 = EntityFactory.makeSimple()
		let e2 = EntityFactory.makeSimple()
		let e3 = EntityFactory.makeDraggable()
		let b1 = EntityFactory.makeScrollable()

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(b1.entity)

		e1.layout.data.localTransform = CGAffineTransformMakeTranslation(10, 0)
		e2.layout.data.localTransform = CGAffineTransformMakeTranslation(130, 0)
		e3.layout.data.localTransform = CGAffineTransformMakeTranslation(250, 0)

		// TODO: Proper adding
		e1.layout.parent = b1.scrollLayout
		e2.layout.parent = b1.scrollLayout
		e3.layout.parent = b1.scrollLayout

		e1.render.parent = b1.render
		e2.render.parent = b1.render
		e3.render.parent = b1.render
	}
}

extension Scene1 {
	static func make(window: Entity) -> Entity {
		let script = Scene1()

		script.window = window

		let scene = Entity(name: String(Scene1.self), components: [script])
		return scene
	}
}
