import Foundation
import CoreGraphics

final class LayoutDataStorage: DataStorage {

	var localTransform = CGAffineTransformIdentity {
		didSet {
			if !CGAffineTransformEqualToTransform(oldValue, self.localTransform) {
				self.incrementVersion()
			}
		}
	}
	
	var boundingBox = CGSize.zero {
		didSet {
			if oldValue != self.boundingBox {
				self.incrementVersion()
			}
		}
	}
}
