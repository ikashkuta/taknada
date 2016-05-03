import Foundation

class RenderWorker: Worker {
	let layoutChangedSignal = Signal<Layout.LayoutDidUpdateFact>()

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.layoutChangedSignal)
	}

	var render: Render!

	override func registerSelf() {
		self.layoutChangedSignal.subscribe { [weak self] fact in
//			guard let sSelf = self else { return }
			// TODO: update layout
		}
	}
}
