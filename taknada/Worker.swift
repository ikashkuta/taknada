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

class TestWorker: Worker {
	let didScroll: Signal<ScrollableInput.DidScrollFact>
	let styleDidUpdate: Signal<Style.StyleDidUpdateFact>
	let layoutDidUpdate: Signal<Layout.LayoutDidUpdateFact>
	override init() {
		self.didScroll = TestSignal(callback: { (fact) in
			print("signal didScroll \(fact)")
		})
		self.styleDidUpdate = TestSignal(callback: { (fact) in
			print("signal styleDidUpdate \(fact)")
		})
		self.layoutDidUpdate = TestSignal(callback: { (fact) in
			print("signal layoutDidUpdate \(fact)")
		})
	}
	override func publishSignals(publisher: SignalPublisher) {
		publisher.publishSignal(self.didScroll)
		publisher.publishSignal(self.layoutDidUpdate)
		publisher.publishSignal(self.styleDidUpdate)
	}
}
