import Foundation

/** All restorable components must be stateless in terms of abilty to recalculate their state fully from inner state of
other components and persistence date. There is no need of something like "virtual dom" because changes in UIKit are
non-atomic (comparing to ones in the browsers). More concrete: "Stateless" means that component doesn't own it's 
layout, colour, border properties, control state, frame, bounds, network. Nothing. It might contain this information
(because of UIKit's and other requirements) but it mustn't own it. All meaningful components must follow this guides.

I'm going to guarantee only two things: all enitity will be restored with their guid and all DataStorage that
entities contain. All other things should be restored by registration architechture of Taknada.
*/
class DataStorage: Component {

	// MARK: - Public API

	// Faster and simpler than Equatable
	final private(set) var version: UInt = 0
	final func incrementVersion() {
		self.version += 1
	}
}
