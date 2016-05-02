import Foundation

// Message must have a name as an event (what's happend) not action (what should happen)
// Semantic is important. Only workers know what to do next.
protocol Fact {
	var source: String { get } // source of event (line, class, etc.) - to make debug easier. Let's beat Rx stuff by it.
}

class Signal<SpecificFact: Fact> {
	typealias FactType = Fact
	func receive(fact: SpecificFact) { }
}

// TODO: Sometimes we want to receive an event as a response from another event we've sent
final class Dispatcher: Component {
	typealias DispatchFunction = (Void) -> Void
	private var dispatchQueue = [DispatchFunction]()
	private var dispatchTable = [String: [AnyObject]]()

	func sendMessage<SpecificFact: Fact>(fact: SpecificFact) {
		self.dispatchQueue.append({
			let factTypeKey = String(SpecificFact.self)
			let maybeSignals = self.dispatchTable[factTypeKey] as? [Signal<SpecificFact>]
			guard let signals: [Signal<SpecificFact>] = maybeSignals else { return }
			for signal in signals {
				signal.receive(fact)
			}
		})
	}

	func registerSignal<FactType: Fact>(signal: Signal<FactType>) {
		let factTypeKey = String(FactType.self)
		if self.dispatchTable[factTypeKey] == nil {
			self.dispatchTable[factTypeKey] = [AnyObject]()
		}
		self.dispatchTable[factTypeKey]!.append(signal)
	}

	func processSending() {
		if self.dispatchQueue.count == 0 { return }
		let queueToProcess = self.dispatchQueue
		self.dispatchQueue.removeAll() // TODO: Not thread-safe :(
		queueToProcess.forEach { $0() }
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.dispatchSystem?.register(self)
	}

	override func unregisterSelf() {
		self.dispatchTable.removeAll()
		self.dispatchQueue.removeAll()
		SystemLocator.dispatchSystem?.unregister(self)
	}
}
