import Foundation
import CoreGraphics
import UIKit

final class TextLayout: Layout {

	// MARK: - Public API

	final var textData: TextDataStorage!

	// MARK: - Layout

	override func update() {
		self.data.boundingBox = self.calcTextSize()
		self.lastUsedDataVersion = self.textData.version

		super.update()
	}

	final private var lastUsedDataVersion = UInt.max

	override var needsUpdate: Bool {
		return super.needsUpdate || self.textData.version != self.lastUsedDataVersion
	}

	// MARK: - Private

	private func calcTextSize() -> CGSize {
		let parentWidth = self.parent!.data.boundingBox.width
		let maxSize = CGSize(width: parentWidth, height: CGFloat.max)
		let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
		let attributes = [
			NSFontAttributeName: self.textData.font,
			NSKernAttributeName: 0
		]
		return self.textData.text.boundingRectWithSize(maxSize,
		                                               options: options,
		                                               attributes: attributes,
		                                               context: nil).size
	}
}
