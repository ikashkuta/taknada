import Foundation

// Message must have a name as an event (what's happend) not action (what should happen) — semantic
// is important. Only workers know what to do next.
protocol Fact {
	var source: String { get } // source of event (line, class, etc.) - to make debug easier. Let's beat Rx stuff by it.
}

final class Dispatcher: Component {

	private(set) var workers: [Worker]!

	func message<SpecificFact: Fact>(fact: SpecificFact) {
		// TODO: Message event across all receivers
		// NOTE: Everybody can message. But only workers can actually listen to events.
		// NOTE: Then scripts update components state appropriately.
		// NOTE: Sometimes we want to receive an event as a response from another event we sent

		print(fact)
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.dispatchSystem?.register(self)
		self.workers = self.getSiblings()
		self.workers.forEach { $0.start() }
	}

	override func unregisterSelf() {
		self.workers.forEach { $0.stop() }
		self.workers = nil
		SystemLocator.dispatchSystem?.unregister(self)
	}
}
