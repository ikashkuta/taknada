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
		let stack = Entity.Stack.make()

		ConventionTags.Basic.getMainRenderData(stack).borderWidth = 1
		ConventionTags.Basic.getMainLayoutData(stack).boundingBox = CGSize(width: 300, height: 300)

		ConventionTags.Window.getManager(window).addEntity(stack)

		e1.layout.data.localTransform = CGAffineTransformMakeTranslation(10, 0)
		e2.layout.data.localTransform = CGAffineTransformMakeTranslation(130, 0)
		e3.layout.data.localTransform = CGAffineTransformMakeTranslation(250, 0)

		ConventionTags.Stack.getManager(stack).addEntity(e1.entity)
		ConventionTags.Stack.getManager(stack).addEntity(e2.entity)
		ConventionTags.Stack.getManager(stack).addEntity(e3.entity)
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
