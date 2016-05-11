import Foundation

final class TextSyncScript: Script {

	// MARK: - Script

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.textDataDidChangeSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		textDataDidChangeSignal.subscribe { (fact) in
			SystemLocator.layoutSystem?.setNeedsUpdate()
			SystemLocator.renderSystem?.setNeedsUpdate()
		}
	}

	// MARK: - Private

	let textDataDidChangeSignal = Signal<TextDataStorage.TextDataDidUpdateFact>()
}
