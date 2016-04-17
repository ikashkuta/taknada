import Foundation
import CoreGraphics

class Layout: Component {
	override func registerSelf() {
		SystemLocator.layoutSystem?.register(self)
	}

	override func unregisterSelf() {
		SystemLocator.layoutSystem?.unregister(self)
	}

	private(set) var children = [Layout]()
	var parent: Layout? {
		willSet {
			// TODO: it must be appropriate datastructure, not Array
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self }
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}

	final private(set) var needsUpdate = false
	final private(set) var globalFrame = CGRect.zero
	final private(set) var globalTransform = CGAffineTransformIdentity
	final func updateState() {
		let parentGlobalTransform = self.parent?.globalTransform ?? self.localTransform
		self.globalTransform = CGAffineTransformConcat(parentGlobalTransform, self.localTransform)
		let frame = CGRect(origin: CGPoint.zero, size: self.boundingBox)
		self.globalFrame = CGRectApplyAffineTransform(frame, self.globalTransform)
		for child in self.children {
			child.updateState()
		}
		self.needsUpdate = false
	}

	var localTransform = CGAffineTransformIdentity {
		didSet {
			if !CGAffineTransformEqualToTransform(oldValue, self.localTransform) {
				self.needsUpdate = true
			}
		}
	}
	var boundingBox = CGSize.zero {
		didSet {
			if !CGSizeEqualToSize(oldValue, self.boundingBox) {
				self.needsUpdate = true
			}
		}
	}
}
