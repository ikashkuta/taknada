import Foundation
import CoreGraphics

class Layout: Component {
	override func registerSelf() {
		SystemLocator.layoutSystem?.register(self)
	}

	override func unregisterSelf() {
		SystemLocator.layoutSystem?.unregister(self)
	}

	// TODO: it must be appropriate datastructure for this tree, not Array
	final private(set) var children = [Layout]()
	final var parent: Layout? {
		willSet {
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self }
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}

	final let data = LayoutData()
	final private(set) var globalFrame = CGRect.zero
	final private(set) var globalTransform = CGAffineTransformIdentity
	final private var lastUsedDataVersion = UInt.max
	final var needsUpdate: Bool {
		return self.data.version != self.lastUsedDataVersion
	}
	final func updateGlobalFrame() {
		let parentGlobalTransform = self.parent?.globalTransform ?? self.data.localTransform
		self.globalTransform = CGAffineTransformConcat(parentGlobalTransform, self.data.localTransform)
		let frame = CGRect(origin: CGPoint.zero, size: self.data.boundingBox)
		self.globalFrame = CGRectApplyAffineTransform(frame, self.globalTransform)
		for child in self.children {
			child.updateGlobalFrame()
		}
		self.lastUsedDataVersion = self.data.version
	}
}

final class LayoutData {
	private(set) var version: UInt = 0
	let guid = "guid"
	var localTransform = CGAffineTransformIdentity {
		didSet {
			if !CGAffineTransformEqualToTransform(oldValue, self.localTransform) {
				self.version += 1
			}
		}
	}
	var boundingBox = CGSize.zero {
		didSet {
			if oldValue != self.boundingBox {
				self.version += 1
			}
		}
	}
}
