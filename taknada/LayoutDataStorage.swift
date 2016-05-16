import Foundation
import CoreGraphics

final class LayoutDataStorage: DataStorage {

	// MARK: - Public API

	var localTransform = CGAffineTransformIdentity {
		didSet {
			if !CGAffineTransformEqualToTransform(oldValue, self.localTransform) {
				self.incrementVersion()
				SystemLocator.layoutSystem?.setNeedsUpdate()
			}
		}
	}
	
	var boundingBox = CGSize.zero {
		didSet {
			if oldValue != self.boundingBox {
				self.incrementVersion()
				SystemLocator.layoutSystem?.setNeedsUpdate()
			}
		}
	}
}
