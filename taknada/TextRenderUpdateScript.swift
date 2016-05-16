import Foundation

final class TextRenderUpdateScript: Script {

	// Public API

	var textRender: TextRender!
	var textData: TextDataStorage!

	// MARK: - Script

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.textDataDidChangeSignal)
		publisher.publishSignal(self.viewHaveBecomeAliveSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()
		
		self.textDataDidChangeSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			if sSelf.hasUpdatedFromLatestData { return }
			sSelf.updateViewFromData()
		}

		self.viewHaveBecomeAliveSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			sSelf.updateViewFromData()
		}
	}

	override func unregisterSelf() {
		self.textData = nil
		self.textRender = nil
		super.unregisterSelf()
	}

	// MARK: - Private

	private let textDataDidChangeSignal = Signal<TextDataStorage.TextDataDidUpdateFact>()
	private let viewHaveBecomeAliveSignal = Signal<Render.ViewHasBecomeAliveFact>()

	private var lastUsedDataVersion = UInt.max

	private var hasUpdatedFromLatestData: Bool {
		return self.textData.version == self.lastUsedDataVersion
	}

	private func updateViewFromData() {
		self.textRender.updateText(self.textData.text)
		self.textRender.updateTextColor(self.textData.textColor)
		self.textRender.updateFont(self.textData.font)
		self.lastUsedDataVersion = self.textData.version
		SystemLocator.layoutSystem?.setNeedsUpdate()
	}
}
