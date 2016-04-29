import Foundation

// Message must have a name as an event (what's happend) not action (what should happen)
// Semantic is important. Only workers know what to do next.
protocol Fact {
	var source: String { get } // source of event (line, class, etc.) - to make debug easier. Let's beat Rx stuff by it.
}

final class Dispatcher: Component {

	private(set) var workers: [Worker]!
	private var awaitingFacts = [Fact]()

	func sendMessage<SpecificFact: Fact>(fact: SpecificFact) {
		// TODO: Sometimes we want to receive an event as a response from another event we sent
		self.awaitingFacts.append(fact)
	}

	final func processSending() {
		if self.awaitingFacts.count == 0 { return }

		let factsToSend = self.awaitingFacts
		self.awaitingFacts.removeAll() // TODO: Not safe for multithreading.

		// TODO: More precise and fast dispatching
		for fact in factsToSend {
			for worker in self.workers {
				// TODO: an actual call
			}
			print(fact)
		}
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
