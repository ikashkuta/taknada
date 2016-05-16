import Foundation
import CoreGraphics

// Lays out it's children to the according direction.
// Also, sets children's dimensions to self's one according
// to opposite direction.
final class StackLayout: Layout {

	// MARK: - Public API

	enum Direction { case horizontal, vertical }

	var direction: Direction = .horizontal

	// MARK: - Layout

	override var needsUpdate: Bool {
		// TODO: remove true when parent's situation will be fixed in Layout.
		return super.needsUpdate || true
	}

	override func update() {
		self.calculate()
		super.update()
	}

	// MARK: - Private

	private func calculate() {
		var transform = CGAffineTransformIdentity
		var totalSizeAlongDirection: CGFloat = 0
		for child in self.children {
			child.data.localTransform = transform
			let tx, ty: CGFloat
			if self.direction == .horizontal {
				tx = child.data.boundingBox.width
				ty = 0
			} else {
				tx = 0
				ty = child.data.boundingBox.height
			}
			transform = CGAffineTransformTranslate(transform, tx, ty)
			totalSizeAlongDirection += tx + ty
		}

		if self.direction == .horizontal {
			self.data.boundingBox.width = totalSizeAlongDirection
		} else {
			self.data.boundingBox.height = totalSizeAlongDirection
		}
	}
}
