import UIKit
extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach(addSubview)
    }
}
