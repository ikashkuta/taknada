import Foundation
import CoreGraphics

class RenderWorker: Worker {

	// MARK: - Public API

	final var render: Render!

	// MARK: - Worker

	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.layoutChangedSignal)
	}

	override func registerSelf() {
		self.layoutChangedSignal.subscribe { [weak self] fact in
			guard let sSelf = self else { return }
			// TODO: update frame lazily
		}
	}

	// MARK: - Private

	private let layoutChangedSignal = Signal<Layout.GlobalFrameDidUpdateFact>()

}
