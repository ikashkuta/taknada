import Foundation
import UIKit

final class RenderDataStorage: DataStorage {

	// MARK: - Public API

	struct RenderDataDidUpdateFact: Fact {
		let source: String
	}

	var backgroundColor: UIColor = UIColor.whiteColor() {
		didSet {
			if oldValue != self.backgroundColor {
				self.incrementVersion()
				self.dispatcher.report(RenderDataDidUpdateFact(source: #function))
			}
		}
	}

	var borderColor: UIColor = UIColor.blackColor() {
		didSet {
			if oldValue != self.borderColor {
				self.incrementVersion()
				self.dispatcher.report(RenderDataDidUpdateFact(source: #function))
			}
		}
	}

	var borderWidth: CGFloat = 0 {
		didSet {
			if oldValue != self.borderWidth {
				self.incrementVersion()
				self.dispatcher.report(RenderDataDidUpdateFact(source: #function))
			}
		}
	}
	
	var cornerRadius: CGFloat = 0 {
		didSet {
			if oldValue != self.cornerRadius {
				self.incrementVersion()
				self.dispatcher.report(RenderDataDidUpdateFact(source: #function))
			}
		}
	}
}

