import Foundation

// Message must have a name as an event (what's happend) not action (what should happen)
// Semantic is important. Only workers know what to do next.
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

	func sendMessage<SpecificFact: Fact>(fact: SpecificFact) {
		self.dispatchQueue.append({
			let factTypeKey = String(SpecificFact.self)
			let maybeSignals = self.dispatchTable[factTypeKey] as? [Signal<SpecificFact>]
			guard let signals: [Signal<SpecificFact>] = maybeSignals else { return }
			for signal in signals {
				signal.push(fact)
			}
		})
	}

	func processSending() {
		if self.needRegisterWorkers { self.registerWorkers() }
		if self.dispatchQueue.count == 0 { return }
		let queueToProcess = self.dispatchQueue
		self.dispatchQueue.removeAll() // TODO: Not thread-safe :(
		queueToProcess.forEach { $0() }
	}

	func publishSignal<FactType: Fact>(signal: Signal<FactType>) {
		let factTypeKey = String(FactType.self)
		if self.dispatchTable[factTypeKey] == nil {
			self.dispatchTable[factTypeKey] = [AnyObject]()
		}
		self.dispatchTable[factTypeKey]!.append(signal)
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

	// MARK: - Private

	typealias DispatchFunction = (Void) -> Void
	private var dispatchQueue = [DispatchFunction]()
	private var dispatchTable = [String: [AnyObject]]()
	private var didRegisterWorkers = false
	private var needRegisterWorkers: Bool { return !self.didRegisterWorkers }

	private func registerWorkers() {
		let workers: [Worker] = self.getSiblings()
		workers.forEach { $0.publishSignals(self) }
		self.didRegisterWorkers = true
	}
}
