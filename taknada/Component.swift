import Foundation

class Component { // TODO: maybe protocol?..
	func registerSelf() {}
	func unregisterSelf() {}

	init() {
		self.registerSelf()
	}
}
