import Foundation

class Component {
	func registerSelf() {}
	func unregisterSelf() {}

	init() {
		self.registerSelf()
	}
}
