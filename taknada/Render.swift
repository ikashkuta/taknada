import Foundation
import UIKit

class Render: Component {

	// MARK: - Public API

	final var basicData: RenderDataStorage!
	final var layout: Layout!
	final var inputs: [Input]?

	final var view: UIView?

	// MARK: - To Override

	func createView() -> UIView {
		return UIView()
	}

	var needsUpdate: Bool {
		return self.basicData.version != self.lastUsedDataVersion
	}

	func update() {
		self.view!.backgroundColor = self.basicData.backgroundColor
		self.view!.layer.borderColor = self.basicData.borderColor.CGColor
		self.view!.layer.borderWidth = self.basicData.borderWidth
		self.view!.layer.cornerRadius = self.basicData.cornerRadius
		self.lastUsedDataVersion = self.basicData.version
	}

	// MARK: - Component

	final override func registerSelf() {
		SystemLocator.renderSystem?.register(self)
	}

	final override func unregisterSelf() {
		self.layout = nil
		SystemLocator.renderSystem?.unregister(self)
	}

	// MARK: - Private

	final private var lastUsedDataVersion = UInt.max


	// MARK: -- Tree

	// TODO: it must be appropriate datastructure for this tree, not Array
	final private(set) var children = [Render]()
	final var parent: Render? {
		willSet {
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self }
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}
}
