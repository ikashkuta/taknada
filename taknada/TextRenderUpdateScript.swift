import Foundation

final class TextRenderUpdateScript: Script {

	// Public API

	var textRender: TextRender!
	var textData: TextDataStorage!

	// MARK: - Script

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.textDataDidChangeSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()
		
		textDataDidChangeSignal.subscribe { [weak self] (_) in
			guard let sSelf = self else { return }
			sSelf.textRender.updateText(sSelf.textData.text)
			sSelf.textRender.updateTextColor(sSelf.textData.textColor)
			sSelf.textRender.updateFont(sSelf.textData.font)
			sSelf.lastUsedDataVersion = sSelf.textData.version
			SystemLocator.layoutSystem?.setNeedsUpdate()
		}
	}

	override func unregisterSelf() {
		self.textData = nil
		self.textRender = nil
		super.unregisterSelf()
	}

	// MARK: - Private

	let textDataDidChangeSignal = Signal<TextDataStorage.TextDataDidUpdateFact>()

	private var lastUsedDataVersion = UInt.max

	private var hasUpdatedFromLatestData: Bool {
		return self.textData.version == self.lastUsedDataVersion
	}
}
