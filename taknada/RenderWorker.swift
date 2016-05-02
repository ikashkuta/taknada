import Foundation

class RenderWorker: Worker {
	let styleChangedSignal = Signal<Style.StyleDidUpdateFact>()
	let layoutChangedSignal = Signal<Layout.LayoutDidUpdateFact>()

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.styleChangedSignal)
		publisher.publishSignal(self.layoutChangedSignal)
	}

	var render: Render!

	override func registerSelf() {
		self.layoutChangedSignal.subscribe { [weak self] fact in
			guard let sSelf = self else { return }
			sSelf.render
		}
	}
}
