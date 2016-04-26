import Foundation

class Script: Component {

	// MARK: - Public

	private(set) var isRunning = false
	final func start() {
		self.isRunning = true
		self.attach()
	}

	final func stop() {
		self.detach()
		self.isRunning = false
	}

	// MARK: - To Subclass

	func attach() {}
	func detach() {}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.dispatchSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.stop()
		SystemLocator.dispatchSystem?.unregister(self)
	}
}
