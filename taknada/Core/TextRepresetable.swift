import Foundation

public protocol TextRepresentable { } // : LosslessStringConvertible

extension String: TextRepresentable {}
extension Int: TextRepresentable {}
extension UInt: TextRepresentable {}
