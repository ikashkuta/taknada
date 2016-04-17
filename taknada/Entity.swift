import Foundation

class Entity {
	let components: [Component]

	init(components: [Component]) {
		self.components = components
	}

	deinit {
		for component in self.components {
			component.unregisterSelf()
		}
	}
}
