import Foundation

// Message must have a name as an event (what's happend) not action (what should happen)
// Semantic is important. Only scripts know what to do next.
protocol Fact {
	var source: String { get } // source of event (line, class, etc.) - to make debug easier. Let's beat Rx stuff by it.
}

// Let's keep it `final` till I find a better solution (Elm's ideas are not that bad actually)
final class Signal<SpecificFact: Fact> {

	// MARK: - Public API

	typealias SubscriberFunction = (SpecificFact) -> Void

	func listen(subscriber: SubscriberFunction) {
		self.subscribers.append(subscriber)
	}

	// MARK: - Private

	private var subscribers = [SubscriberFunction]()

	private func push(fact: SpecificFact) {
		self.subscribers.forEach { $0(fact) }
	}
}

protocol SignalPublisher {
	func publishSignal<FactType: Fact>(signal: Signal<FactType>)
}

// Think of it as a Manager of Entity (in other words, manager of entity team of components ;)
// Duties:
// Defines entity: knows everything about it. In fact, usually standard Manager is fine.
// Collects all reports, passes them to other parts of entity, explicitly passes some reports to its supervisor.
class Manager: Component, SignalPublisher {

	// MARK: - Public API

	final func report<SpecificFact: Fact>(fact: SpecificFact) {
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

	final func publishSignal<SpecificFact: Fact>(signal: Signal<SpecificFact>) {
		let factTypeKey = String(SpecificFact.self)
		if self.dispatchMessageTable[factTypeKey] == nil {
			self.dispatchMessageTable[factTypeKey] = [Signal<SpecificFact>]()
		}
		self.dispatchMessageTable[factTypeKey]!.append(signal)
	}

	let dispatchQueue = dispatch_queue_create("dispatcher", DISPATCH_QUEUE_SERIAL)

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.scriptSystem?.register(self)
	}

	override func unregisterSelf() {
		self.dispatchMessageTable.removeAll() // TODO: alarm, potentially at this point some blocks may be in the queue
		SystemLocator.scriptSystem?.unregister(self)
	}

	// MARK: - Private

	private var dispatchMessageTable = [String: [AnyObject]]()
	private var didRegisterScripts: dispatch_once_t = 0
}
