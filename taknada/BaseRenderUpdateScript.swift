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
		publisher.publishSignal(self.viewHaveBecomeAliveSignal)
	}

	// MARK: - Component

	override func registerSelf() {
		super.registerSelf()

		self.globalFrameDidChangeSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			let isLayoutVisible = SystemLocator.layoutSystem?.isLayoutVisible(sSelf.layout) ?? false
			sSelf.render.updateView(alive: isLayoutVisible)
			sSelf.render.updateFrame(sSelf.layout.globalFrame)
		}

		self.viewHaveBecomeAliveSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			sSelf.updateViewFromData()
		}

		self.renderDataDidChangeSignal.listen { [weak self] (_) in
			guard let sSelf = self else { return }
			if sSelf.hasUpdatedFromLatestData { return }
			sSelf.updateViewFromData()
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
	private let viewHaveBecomeAliveSignal = Signal<Render.ViewHasBecomeAliveFact>()

	private var lastUsedDataVersion = UInt.max

	private var hasUpdatedFromLatestData: Bool {
		return self.data.version == self.lastUsedDataVersion
	}

	private func updateViewFromData() {
		self.render.updateBorderColor(self.data.borderColor)
		self.render.updateBorderWidth(self.data.borderWidth)
		self.render.updateCornerRadius(self.data.cornerRadius)
		self.render.updateBackgroundColor(self.data.backgroundColor)
		self.lastUsedDataVersion = self.data.version
	}
}
