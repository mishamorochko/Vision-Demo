import UIKit

final class TextRecognitionViewModel {

    // MARK: - Properties
    // MARK: Public

    weak var router: TextRecognitionRouterInput?

    // MARK: Private

    // MARK: - Initializers

    init() {}

    // MARK: - API

    func becomeActive() {}

    func chooseImage() {
        let actionSheet = UIAlertController(title: "Choose image from:", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.router?.openCamera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.router?.openGallery()
        }))

        actionSheet.addAction(UIAlertAction(title: "Test image", style: .default, handler: { _ in
            self.router?.openTestImage()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        router!.presentImageActionSheet(actionSheet: actionSheet)
    }
}
