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
		let stack = Entity.makeStack()

		let stackRenderData: RenderDataStorage = stack.getComponent(ConventionTags.mainRenderData)
		stackRenderData.borderWidth = 1

		let stackLayoutData: LayoutDataStorage = stack.getComponent(ConventionTags.mainLayoutData)
		stackLayoutData.boundingBox = CGSize(width: 300, height: 300)

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(stack)

		e1.layout.data.localTransform = CGAffineTransformMakeTranslation(10, 0)
		e2.layout.data.localTransform = CGAffineTransformMakeTranslation(130, 0)
		e3.layout.data.localTransform = CGAffineTransformMakeTranslation(250, 0)

		let stackManager: StackManager = stack.getComponent(ConventionTags.mainManager)
		stackManager.addEntity(e1.entity)
		stackManager.addEntity(e2.entity)
		stackManager.addEntity(e3.entity)
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
