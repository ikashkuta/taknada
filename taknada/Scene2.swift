import Foundation
import UIKit

class Scene2: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let e1 = Entity.DraggableRect.make()
		let e2 = Entity.DraggableRect.make()
		let e3 = Entity.DraggableRect.make()

		let windowManager: WindowManager = window.getComponent(ConventionTags.Window.manager)
		windowManager.addEntity(e1)
		windowManager.addEntity(e2)
		windowManager.addEntity(e3)

		Scene2.styleDraggable(e3)
		Scene2.styleDraggable(e2)
		Scene2.styleDraggable(e1)
	}

	// MARK: - Private

	static func styleDraggable(entity: Entity) {
		ConventionTags.Basic.getMainLayoutData(entity).boundingBox = CGSize(width: 100, height: 100)
		ConventionTags.Basic.getMainRenderData(entity).backgroundColor = UIColor.purpleColor()
		ConventionTags.Basic.getMainRenderData(entity).borderWidth = 3
		ConventionTags.Basic.getMainRenderData(entity).borderColor = UIColor.blueColor()
		ConventionTags.Basic.getMainRenderData(entity).cornerRadius = 10
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
