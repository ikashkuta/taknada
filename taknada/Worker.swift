import Foundation

class Worker: Component {
	func publishSignals(publisher: SignalPublisher) {
	}
}

class TestSignal<SpecificFact: Fact>: Signal<SpecificFact> {
	typealias CallbackType = (SpecificFact) -> Void
	private let callback: CallbackType
	init(callback: CallbackType) {
		self.callback = callback
	}
	override func receive(fact: SpecificFact) {
		self.callback(fact)
	}
}

