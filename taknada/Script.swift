import Foundation

class Script: Component {
	func attach() { }
	func detach() { }

	override func unregisterSelf() {
		self.detach()
	}
}
