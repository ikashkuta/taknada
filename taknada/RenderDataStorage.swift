import Foundation
import UIKit

final class RenderDataStorage: DataStorage {
	var backgroundColor: UIColor = UIColor.whiteColor() {
		didSet {
			if oldValue != self.backgroundColor {
				self.incrementVersion()
			}
		}
	}
	var borderColor: UIColor = UIColor.blackColor() {
		didSet {
			if oldValue != self.borderColor {
				self.incrementVersion()
			}
		}
	}
	var borderWidth: CGFloat = 0 {
		didSet {
			if oldValue != self.borderWidth {
				self.incrementVersion()
			}
		}
	}
	var cornerRadius: CGFloat = 0 {
		didSet {
			if oldValue != self.cornerRadius {
				self.incrementVersion()
			}
		}
	}
}

