import Foundation
import UIKit

extension UIColor: TextRepresentable {}
extension CGRect: TextRepresentable {}
extension CGFloat: TextRepresentable {}

extension ConventionKeys {
    struct UIKitComponent {
        static let cornerRadius = "corner_radius"
        static let borderColor = "border_color"
        static let borderWidth = "border_width"
        static let backgroundColor = "background_color"
        static let frame = "frame"
    }
}

class UIKitComponent: Component {

    // MARK: API

    final var entity: Entity!

    final var view: UIView? {
        didSet {
            guard let view = view else { return }

            // TODO: it's completely wrong :(
            view.frame = entity.read(key: ConventionKeys.UIKitComponent.frame)!
            view.backgroundColor = entity.read(key: ConventionKeys.UIKitComponent.backgroundColor)
        }
    }

    // MARK: To Override

    func createView() -> UIView {
        return UIView()
    }

    // MARK: Component

    required init() {
    }

    func attach(to entity: Entity) {
        self.entity = entity

        // TODO: All of this updates must happen on UIKitSystem queue

        entity.observe(key: ConventionKeys.UIKitComponent.backgroundColor) { (color: UIColor) in
            self.view?.backgroundColor = color
        }

        entity.observe(key: ConventionKeys.UIKitComponent.frame) { (frame: CGRect) in
            self.view?.frame = frame
        }

        entity.observe(key: ConventionKeys.UIKitComponent.borderColor) { (borderColor: UIColor) in
            self.view?.layer.borderColor = borderColor.cgColor
        }

        entity.observe(key: ConventionKeys.UIKitComponent.borderWidth) { (borderWidth: CGFloat) in
            self.view?.layer.borderWidth = borderWidth
        }

        entity.observe(key: ConventionKeys.UIKitComponent.cornerRadius) { (cornerRadius: CGFloat) in
            self.view?.layer.cornerRadius = cornerRadius
        }
    }

    func detach() {
        self.view?.removeFromSuperview()
        self.view = nil
    }
}

extension UIKitComponent: Equatable {

    public static func ==(lhs: UIKitComponent, rhs: UIKitComponent) -> Bool {
        return lhs === rhs
    }
}

extension UIKitComponent: Hashable {

    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
