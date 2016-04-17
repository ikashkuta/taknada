import Foundation

class Behavior: Component {
	func attach() { }
	func detach() { }

	override func unregisterSelf() {
		self.detach()
	}
}
