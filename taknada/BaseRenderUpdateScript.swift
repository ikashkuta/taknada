import Foundation

final class BaseRenderUpdateScript: Script {

	// MARK: Public API

	var render: Render!
	var layout: Layout!
	var data: RenderDataStorage!

	// MARK: - Script

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.globalFrameDidChangeSignal)
		publisher.publishSignal(self.renderDataDidChangeSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		globalFrameDidChangeSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			sSelf.render.updateFrame(sSelf.layout.globalFrame)
		}

		renderDataDidChangeSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			if sSelf.hasUpdatedFromLatestData { return }
			sSelf.render.updateBorderColor(sSelf.data.borderColor)
			sSelf.render.updateBorderWidth(sSelf.data.borderWidth)
			sSelf.render.updateCornerRadius(sSelf.data.cornerRadius)
			sSelf.render.updateBackgroundColor(sSelf.data.backgroundColor)
			sSelf.lastUsedDataVersion = sSelf.data.version
		}
	}

	override func unregisterSelf() {
		self.render = nil
		self.layout = nil
		self.data = nil
		super.unregisterSelf()
	}

	// MARK: - Private

	private let globalFrameDidChangeSignal = Signal<Layout.GlobalFrameDidUpdateFact>()
	private let renderDataDidChangeSignal = Signal<RenderDataStorage.RenderDataDidUpdateFact>()

	private var lastUsedDataVersion = UInt.max

	private var hasUpdatedFromLatestData: Bool {
		return self.data.version == self.lastUsedDataVersion
	}
}
