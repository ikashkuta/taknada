import Foundation

class Script: Component {

	// MARK: - Public

	private(set) var isRunning = false
	final func start() {
		self.isRunning = true
	}

	final func stop() {
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
