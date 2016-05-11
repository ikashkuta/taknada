import Foundation
import UIKit

final class TextRender: Render {

	// MARK: - Public API

	final var textData: TextDataStorage!

	// MARK: - Render

	override func createView() -> UIView {
		let view = UILabel()
		view.numberOfLines = 0
		return view
	}

	override var needsUpdate: Bool {
		return super.needsUpdate || self.textData.version != lastUsedDataVersion
	}

	override func update() {
		super.update()

		let label = self.view as! UILabel
		label.text = self.textData.text
		label.font = self.textData.font
		label.textColor = self.textData.textColor
	}

	// MARK: - Private

	private var lastUsedDataVersion = UInt.max
}
