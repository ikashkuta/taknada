import Foundation

class Worker: Component {

	private(set) var isRunning = false
	func start() {
		self.isRunning = true
	}

	func stop() {
		self.isRunning = false
	}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.dispatchSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.stop()
		SystemLocator.dispatchSystem?.unregister(self)
	}
}
