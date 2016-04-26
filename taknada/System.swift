import Foundation

protocol System {
	associatedtype ComponentType: Component

	func register(component: ComponentType)
	func unregister(component: ComponentType)

	func update()
}
