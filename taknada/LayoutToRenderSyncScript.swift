import Foundation

final class LayoutToRenderSyncScript: Script {

	// MARK: - Script

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.layoutDidChangeSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		layoutDidChangeSignal.subscribe { (fact) in
			SystemLocator.renderSystem?.setNeedsUpdate()
		}
	}

	// MARK: - Private

	let layoutDidChangeSignal = Signal<Layout.GlobalFrameDidUpdateFact>()
}
