import UIKit
protocol TextRecognitionRouterInput: Router {
    func presentImageActionSheet(actionSheet: UIAlertController)
    func openCamera()
    func openGallery()
    func openTestImage()
}
