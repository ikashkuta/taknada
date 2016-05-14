import Foundation
import UIKit

final class TextDataStorage: DataStorage {

	// MARK: - Public API

	struct TextDataDidUpdateFact: Fact {
		let source: String
	}

	var text: String = "" {
		didSet {
			if oldValue != self.text {
				self.incrementVersion()
				self.dispatcher.report(TextDataDidUpdateFact(source: #function))
			}
		}
	}

	var font: UIFont = UIFont.systemFontOfSize(17) {
		didSet {
			if oldValue != self.font {
				self.incrementVersion()
				self.dispatcher.report(TextDataDidUpdateFact(source: #function))
			}
		}
	}

	var textColor: UIColor = UIColor.blackColor() {
		didSet {
			if oldValue != self.textColor {
				self.incrementVersion()
				self.dispatcher.report(TextDataDidUpdateFact(source: #function))
			}
		}
	}
}
