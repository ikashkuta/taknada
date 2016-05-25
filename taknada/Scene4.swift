import Foundation
import UIKit

class Scene4: Script {

	// MARK: - Public API

	var window: Entity!

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		let t1 = EntityFactory.makeText()
		let t2 = EntityFactory.makeText()
		let t3 = EntityFactory.makeText()
		let t4 = EntityFactory.makeText()
		let t5 = EntityFactory.makeText()
		let t6 = EntityFactory.makeText()
		let t7 = EntityFactory.makeText()
		let t8 = EntityFactory.makeText()
		let stack = Entity.makeStack()

		let stackRenderData: RenderDataStorage = stack.getComponent(ConventionTags.mainRenderData)
		stackRenderData.borderWidth = 1

		let stackLayoutData: LayoutDataStorage = stack.getComponent(ConventionTags.mainLayoutData)
		stackLayoutData.boundingBox = CGSize(width: 300, height: 300)

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(stack)

		t1.textData.text = "Hello"
		t1.textData.font = UIFont.systemFontOfSize(30)
		t2.textData.text = "My name is"
		t3.textData.text = "Always IGOR!!!!!!!!!"
		t3.textData.textColor = UIColor.blueColor()
		t4.textData.text = "And yours? Yours! Yours! Yours! Yours! Yours! Yours! Yours! Yours!"
		t4.textData.font = UIFont.systemFontOfSize(10)
		t5.textData.text = "What is you name? Say again? I didn't hear you."
		t6.textData.text = "VADOS?"
		t7.textData.textColor = UIColor.purpleColor()
		t7.textData.text = "What is it?"
		t8.textData.text = "Some kind of OS?"

		let stackManager: StackManager = stack.getComponent(ConventionTags.mainManager)
		stackManager.addEntity(t1.entity)
		stackManager.addEntity(t2.entity)
		stackManager.addEntity(t3.entity)
		stackManager.addEntity(t4.entity)
		stackManager.addEntity(t5.entity)
		stackManager.addEntity(t6.entity)
		stackManager.addEntity(t7.entity)
		stackManager.addEntity(t8.entity)
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
