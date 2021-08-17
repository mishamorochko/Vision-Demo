import UIKit

protocol TextRecognitionRouterProtocol: Router {
    func presentImageActionSheet(actionSheet: UIAlertController)
    func actionForChoosedType(_ type: TextRecognitionRouteType, selectedImageCompletion: @escaping((UIImage)->Void))
}
