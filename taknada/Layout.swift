import Foundation
import CoreGraphics

class Layout: Component {

	// MARK: - Public API

	struct GlobalFrameDidUpdateFact: Fact {
		let source: String
	}

	final var data: LayoutDataStorage!

	final private(set) var globalFrame = CGRect.zero
	
	final private(set) var globalTransform = CGAffineTransformIdentity

	final private(set) var children = [Layout]()

	final var parent: Layout? {
		willSet {
			guard let parent = self.parent else { return }
			parent.children = parent.children.filter { $0 !== self } // TODO: soooo bad :(
		}
		didSet {
			guard let parent = self.parent else { return }
			parent.children.append(self)
		}
	}

	// MARK: - To Override

	func update() {
		self.updateGlobalFrame()
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.layoutSystem?.register(self)
	}

	override func unregisterSelf() {
		self.data = nil
		self.parent = nil
		SystemLocator.layoutSystem?.unregister(self)
	}

	// MARK: - Private

	final private var lastUsedDataVersion = UInt.max

	// TODO: when I finally have versions thrown away this should be private, because now every
	// subclass have to mix it's own logic into this property :(
	var needsUpdate: Bool {
		return self.data.version != self.lastUsedDataVersion
	}

	private final func updateGlobalFrame() {
		let parentGlobalTransform = self.parent?.globalTransform ?? self.data.localTransform
		self.globalTransform = CGAffineTransformConcat(parentGlobalTransform, self.data.localTransform)
		let frame = CGRect(origin: CGPoint.zero, size: self.data.boundingBox)
		self.globalFrame = CGRectApplyAffineTransform(frame, self.globalTransform)
		for child in self.children {
			child.updateGlobalFrame()
		}
		self.globalFrame = CGRectIntegral(self.globalFrame)

		self.lastUsedDataVersion = self.data.version

		let dispatcher: Dispatcher = self.getSibling()
		dispatcher.sendMessage(GlobalFrameDidUpdateFact(source: #function))
	}
}
