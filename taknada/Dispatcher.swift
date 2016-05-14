import Foundation

// Message must have a name as an event (what's happend) not action (what should happen)
// Semantic is important. Only scripts know what to do next.
protocol Fact {
	var source: String { get } // source of event (line, class, etc.) - to make debug easier. Let's beat Rx stuff by it.
}

// Let's keep it `final` till I find a better solution (Elm's ideas are not that bad actually)
final class Signal<SpecificFact: Fact> {
	typealias FactType = Fact

	// TODO: when returned signal will be deallocated?..
	func map<AnotherFact: Fact>(mapFunction: (SpecificFact) -> AnotherFact) -> Signal<AnotherFact> {
		let anotherSignal = Signal<AnotherFact>()
		self.subscribe { (fact) in
			let anotherFact = mapFunction(fact)
			anotherSignal.push(anotherFact)
		}
		return anotherSignal
	}

	// TODO: when returned signal will be deallocated?..
	func filter(filterFunction: (SpecificFact) -> Bool) -> Signal<SpecificFact> {
		let filteredSignal = Signal<SpecificFact>()
		self.subscribe { (fact) in
			if filterFunction(fact) {
				filteredSignal.push(fact)
			}
		}
		return filteredSignal
	}

	typealias SubscriberFunction = (SpecificFact) -> Void
	func subscribe(subscriber: SubscriberFunction) {
		self.subscribers.append(subscriber)
	}

	private var subscribers = [SubscriberFunction]()
	private func push(fact: SpecificFact) {
		self.subscribers.forEach { $0(fact) }
	}
}

protocol SignalPublisher {
	func publishSignal<FactType: Fact>(signal: Signal<FactType>)
}

final class Dispatcher: Component, SignalPublisher {

	// MARK: - Public API

	func report<SpecificFact: Fact>(fact: SpecificFact) {
		dispatch_once(&self.didRegisterScripts) {
			let scripts: [Script] = self.getSiblings()
			scripts.forEach { $0.publishSignals(self) }
		}
		
		dispatch_async(self.dispatchQueue, {
			let factTypeKey = String(SpecificFact.self)
			let maybeSignals = self.dispatchMessageTable[factTypeKey] as? [Signal<SpecificFact>]
			guard let signals: [Signal<SpecificFact>] = maybeSignals else { return }
			for signal in signals {
				signal.push(fact)
			}
		})
	}

	func publishSignal<SpecificFact: Fact>(signal: Signal<SpecificFact>) {
		let factTypeKey = String(SpecificFact.self)
		if self.dispatchMessageTable[factTypeKey] == nil {
			self.dispatchMessageTable[factTypeKey] = [Signal<SpecificFact>]()
		}
		self.dispatchMessageTable[factTypeKey]!.append(signal)
	}

	let dispatchQueue = dispatch_queue_create("dispatcher", DISPATCH_QUEUE_SERIAL)

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.dispatchSystem?.register(self)
	}

	override func unregisterSelf() {
		self.dispatchMessageTable.removeAll() // TODO: alarm, potentially at this point some blocks may be in the queue
		SystemLocator.dispatchSystem?.unregister(self)
	}

	// MARK: - Private

	private var dispatchMessageTable = [String: [AnyObject]]()
	private var didRegisterScripts: dispatch_once_t = 0
}
