import Foundation

public protocol Textable { } // : LosslessStringConvertible

extension String: Textable {}
extension UInt: Textable {}
