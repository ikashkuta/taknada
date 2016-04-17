import Foundation
import UIKit

class Style: Component {
	var backgroundColor: UIColor?
	var borderColor: UIColor?
	var borderWidth: CGFloat = 0
	var cornerRadius: CGFloat = 0
}

extension Style {
	func styleView(view: UIView) {
		view.backgroundColor = self.backgroundColor
		view.layer.borderColor = self.borderColor?.CGColor
		view.layer.borderWidth = self.borderWidth
		view.layer.cornerRadius = self.cornerRadius
	}
}
