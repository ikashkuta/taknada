import Foundation

// This script was actually needed to implement lazy data update propogation, otherwise
// we should check for this always in update(). Whole idea with scripts and state was about laziness so
// we don't have to check everything everytime. Messages wake up runloop to deliver them to scripts, scripts
// will update the state of components, which will cause new wave of messages to render's script which will
// update the state
final class RenderUpdateScript: Script {

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
