import UIKit

final class TextRecognitionViewModel {

    // MARK: - Properties
    // MARK: Public

    weak var router: TextRecognitionRouterProtocol?

    // MARK: Private

    // MARK: - API

    func openImagePickerAction(for type: TextRecognitionRouteType, selectedImageCompletion: @escaping ((UIImage) -> Void)) {
        router?.actionForChoosedType(type, selectedImageCompletion: selectedImageCompletion)
    }

    func present(actionSheet: UIAlertController) {
        router?.presentImageActionSheet(actionSheet: actionSheet)
    }
}
