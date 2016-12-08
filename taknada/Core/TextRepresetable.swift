import Foundation

public protocol TextRepresentable { } // : LosslessStringConvertible

extension String: TextRepresentable {}
extension UInt: TextRepresentable {}
