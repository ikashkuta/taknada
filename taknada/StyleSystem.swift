import Foundation

final class StyleSystem: System<Style> {
	override func update() {
		for style in self.components {
			if style.needsUpdate {
				style.update()
			}
		}
	}
}
