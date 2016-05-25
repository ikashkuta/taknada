import Foundation
import UIKit

class Scene1: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let e1 = Entity.SimpleRect.make()
		let e2 = Entity.SimpleRect.make()
		let e3 = Entity.DraggableRect.make()
		let stack = Entity.Stack.make()

		ConventionTags.Basic.getMainRenderData(stack).borderWidth = 1
		ConventionTags.Basic.getMainLayoutData(stack).boundingBox = CGSize(width: 300, height: 300)

		ConventionTags.Window.getManager(window).addEntity(stack)

		ConventionTags.Stack.getManager(stack).addEntity(e1)
		ConventionTags.Stack.getManager(stack).addEntity(e2)
		ConventionTags.Stack.getManager(stack).addEntity(e3)

		Scene1.styleDraggable(e3)
		Scene1.styleSimple(e2)
		Scene1.styleSimple(e1)
	}

	// MARK: - Private

	static func styleSimple(entity: Entity) {
		ConventionTags.Basic.getMainLayoutData(entity).boundingBox = CGSize(width: 100, height: 200)
		ConventionTags.Basic.getMainRenderData(entity).backgroundColor = UIColor.purpleColor()
		ConventionTags.Basic.getMainRenderData(entity).borderWidth = 3
		ConventionTags.Basic.getMainRenderData(entity).borderColor = UIColor.blueColor()
		ConventionTags.Basic.getMainRenderData(entity).cornerRadius = 10
	}

	static func styleDraggable(entity: Entity) {
		ConventionTags.Basic.getMainLayoutData(entity).boundingBox = CGSize(width: 100, height: 100)
		ConventionTags.Basic.getMainRenderData(entity).backgroundColor = UIColor.purpleColor()
		ConventionTags.Basic.getMainRenderData(entity).borderWidth = 3
		ConventionTags.Basic.getMainRenderData(entity).borderColor = UIColor.blueColor()
		ConventionTags.Basic.getMainRenderData(entity).cornerRadius = 10
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
