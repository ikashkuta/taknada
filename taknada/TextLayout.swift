import Foundation
import CoreGraphics
import UIKit

final class TextLayout: Layout {

	// MARK: - Public API

	final var textData: TextDataStorage!

	// MARK: - Layout

	override func update() {
		self.data.boundingBox = self.calculateTextSize()
		self.lastUsedDataVersion = self.textData.version
		super.update()
	}

	override var needsUpdate: Bool {
		// TODO: remove true when parent's situation will be fixed in Layout.
		return super.needsUpdate || self.textData.version != self.lastUsedDataVersion || true
	}


	// MARK: - Component

	override func unregisterSelf() {
		self.textData = nil
		super.unregisterSelf()
	}

	// MARK: - Private

	// TODO: Actually, it seems that it should be inside of script not layout component..
	private var lastUsedDataVersion = UInt.max

	private func calculateTextSize() -> CGSize {
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
