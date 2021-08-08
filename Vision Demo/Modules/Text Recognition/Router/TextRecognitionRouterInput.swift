import UIKit

protocol TextRecognitionRouterInput: Router {
    func presentImageActionSheet(actionSheet: UIAlertController)
    func actionForChoosedType(_ type: TextRecognitionRouteType)
}
