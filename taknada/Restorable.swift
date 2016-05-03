import Foundation

protocol PersistentData {
	var guid: String { get } // may be different for compile time (entity, useful for editortime) and runtime (instance of entity)
	var name: String { get } // some meaningful name, that makes sense for entity. "MainLayout", "ScrollableLayout", "ScrollableInput"
	var version: UInt { get } // used for determing need for component's update. Otherwise we need to demand conformance to Equitable
	// Other data
}

/** All restorable components must be stateless in terms of abilty to recalculate their state fully from inner state of
other components and persistence date. There is no need of something like "virtual dom" because changes in UIKit are
non-atomic (comparing to ones in the browsers). More concrete: "Stateless" means that component doesn't own it's 
layout, colour, border properties, control state, frame, bounds, network. Nothing. It might contain this information
(because of UIKit's and other requirements) but it mustn't own it. All meaningful components must follow this guides.
*/
protocol Restorable {
	// TODO: if Component type will conform this protocol then it's the solution for components connection problem!
	associatedtype DataType: PersistentData
	var data: DataType { get }
}
