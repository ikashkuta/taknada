import Foundation
import UIKit

final class TextRender: Render {

	// MARK: - Public API

	final var textData: TextDataStorage!

	final func updateText(text: String) {
		self.commitUpdate {
			let label = self.view as! UILabel
			label.text = self.textData.text
		}
	}

	final func updateFont(font: UIFont) {
		self.commitUpdate {
			let label = self.view as! UILabel
			label.font = self.textData.font
		}
	}

	final func updateTextColor(textColor: UIColor) {
		self.commitUpdate {
			let label = self.view as! UILabel
			label.textColor = self.textData.textColor
		}
	}

	// MARK: - Render

	override func createView() -> UIView {
		let view = UILabel()
		view.numberOfLines = 0
		return view
	}


	// MARK: - Component

	override func unregisterSelf() {
		self.textData = nil
		super.unregisterSelf()
	}
}
