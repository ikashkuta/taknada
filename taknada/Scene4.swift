import Foundation
import UIKit

class Scene4: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let t1 = Entity.Text.make()
		let t2 = Entity.Text.make()
		let t3 = Entity.Text.make()
		let t4 = Entity.Text.make()
		let t5 = Entity.Text.make()
		let t6 = Entity.Text.make()
		let t7 = Entity.Text.make()
		let t8 = Entity.Text.make()
		let stack = Entity.Stack.make()

		let stackRenderData: RenderDataStorage = stack.getComponent(ConventionTags.Basic.mainRenderData)
		stackRenderData.borderWidth = 1

		let stackLayoutData: LayoutDataStorage = stack.getComponent(ConventionTags.Basic.mainLayoutData)
		stackLayoutData.boundingBox = CGSize(width: 300, height: 300)

		let windowManager: WindowManager = window.getComponent(ConventionTags.Basic.mainManager)
		windowManager.addEntity(stack)

		ConventionTags.Text.getMainTextData(t1).text = "Hello"
		ConventionTags.Text.getMainTextData(t1).font = UIFont.systemFontOfSize(30)
		ConventionTags.Text.getMainTextData(t2).text = "My name is"
		ConventionTags.Text.getMainTextData(t3).text = "Always IGOR!!!!!!!!!"
		ConventionTags.Text.getMainTextData(t3).textColor = UIColor.blueColor()
		ConventionTags.Text.getMainTextData(t4).text = "And yours? Yours! Yours! Yours! Yours! Yours! Yours! Yours! Yours!"
		ConventionTags.Text.getMainTextData(t4).font = UIFont.systemFontOfSize(10)
		ConventionTags.Text.getMainTextData(t5).text = "What is you name? Say again? I didn't hear you."
		ConventionTags.Text.getMainTextData(t6).text = "VADOS?"
		ConventionTags.Text.getMainTextData(t7).textColor = UIColor.purpleColor()
		ConventionTags.Text.getMainTextData(t7).text = "What is it?"
		ConventionTags.Text.getMainTextData(t8).text = "Some kind of OS?"

		let stackManager: StackManager = stack.getComponent(ConventionTags.Basic.mainManager)
		stackManager.addEntity(t1)
		stackManager.addEntity(t2)
		stackManager.addEntity(t3)
		stackManager.addEntity(t4)
		stackManager.addEntity(t5)
		stackManager.addEntity(t6)
		stackManager.addEntity(t7)
		stackManager.addEntity(t8)
	}
}

extension Scene4 {
	static func make(window: Entity) -> Entity {
		let script = Scene4()

		script.window = window

		let scene = Entity(name: String(Scene4.self), components: [script])
		return scene
	}
}
