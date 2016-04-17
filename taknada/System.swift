import Foundation

protocol System {
	associatedtype ComponentType
	func register(component: ComponentType)
	func unregister(component: ComponentType)

	func update()
}
