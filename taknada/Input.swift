import Foundation

// At the moment, it's not clear, who is responsible for such kind of things - scripts or renders.
// For now let's extract this into separate component which will be attached to the Render's view
// right after it's creation. The main purpose of it is to handle user input, do necessary work and
// message event to others. The thing is that it cannot be done via events since it has to handle
// all user input synchronously - but it should be as dumb as possible.
class Input: Component {

	// This pair of functions may be called several times during lifetime of this
	// component because views may be removed/restored by RenderSystem according
	// to their layout position.
	func attach() {}
	func detach() {}

	// MARK: - Component

	override func registerSelf() {

	}

	override func unregisterSelf() {
		self.detach()
	}
}
