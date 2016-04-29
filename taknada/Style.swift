import Foundation
import UIKit

class Style: Component {
	final let data = StyleData()

	struct StyleDidUpdateFact: Fact {
		var source: String
	}

	final private var lastUsedDataVersion = UInt.max
	final var needsUpdate: Bool {
		return self.data.version != self.lastUsedDataVersion
	}
	final func update() {
		self.lastUsedDataVersion = self.data.version
		let dispatcher: Dispatcher = self.getSibling()
		dispatcher.sendMessage(StyleDidUpdateFact(source: #function))
	}

	// MARK: - Component

	override func registerSelf() {
		SystemLocator.styleSystem?.register(self)
	}

	override func unregisterSelf() {
		SystemLocator.styleSystem?.unregister(self)
	}
}

final class StyleData {
	private(set) var version: UInt = 0
	let guid = "style_guid_uniq-num-per-instance"

	var backgroundColor: UIColor? {
		didSet {
			if oldValue != self.backgroundColor {
				self.version += 1
			}
		}
	}
	var borderColor: UIColor? {
		didSet {
			if oldValue != self.borderColor {
				self.version += 1
			}
		}
	}
	var borderWidth: CGFloat = 0 {
		didSet {
			if oldValue != self.borderWidth {
				self.version += 1
			}
		}
	}
	var cornerRadius: CGFloat = 0 {
		didSet {
			if oldValue != self.cornerRadius {
				self.version += 1
			}
		}
	}
}
