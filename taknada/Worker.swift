import Foundation

class Worker: Component {
	func registerSignals(dispatcher: Dispatcher) {
	}
	func unregisterSignals(dispatcher: Dispatcher) {
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
	override func registerSignals(dispatcher: Dispatcher) {
		dispatcher.registerSignal(self.didScroll)
		dispatcher.registerSignal(self.layoutDidUpdate)
		dispatcher.registerSignal(self.styleDidUpdate)
	}
}
