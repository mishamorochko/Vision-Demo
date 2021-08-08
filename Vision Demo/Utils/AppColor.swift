import UIKit

enum AppColor {
    case mainColor
    case secondaryColor
}

extension AppColor {
    var uiColor: UIColor {
        get {
            switch self {
            case .mainColor: return UIColor(named: "MainColor") ?? .red
            case .secondaryColor: return UIColor(named: "SecondColor") ?? .red
            }
        }
    }
    
    var cgColor: CGColor {
        get {
            switch self {
            case .mainColor: return uiColor.cgColor
            case .secondaryColor: return uiColor.cgColor
            }
        }
    }
}
