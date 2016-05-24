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
		let b1 = EntityFactory.makeScrollable()

		let windowManager: WindowManager = window.getComponent(ConventionTags.mainManager)
		windowManager.addEntity(b1.entity)

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

		// TODO: Proper adding
		t1.layout.parent = b1.scrollLayout
		t2.layout.parent = b1.scrollLayout
		t3.layout.parent = b1.scrollLayout
		t4.layout.parent = b1.scrollLayout
		t5.layout.parent = b1.scrollLayout
		t6.layout.parent = b1.scrollLayout
		t7.layout.parent = b1.scrollLayout
		t8.layout.parent = b1.scrollLayout

		t1.render.parent = b1.render
		t2.render.parent = b1.render
		t3.render.parent = b1.render
		t4.render.parent = b1.render
		t5.render.parent = b1.render
		t6.render.parent = b1.render
		t7.render.parent = b1.render
		t8.render.parent = b1.render
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
