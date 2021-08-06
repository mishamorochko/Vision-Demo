import UIKit

final class TextRecognitionRouter: UIViewController, TextRecognitionRouterInput {
    
    // MARK: - Properties
    // MARK: Private
    
    private let completion: (() -> Void)?
    var model: TextRecognitionViewModel?
    var viewController: TextRecognitionViewInput?
    
    // MARK: - Initialiers
    
    init(completion: (() -> Void)? = nil) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        completion?()
        #if DEBUG
        print("TextRecognitionRouter deinit")
        #endif
    }
    
    func presentImageActionSheet(actionSheet: UIAlertController) {
        present(actionSheet)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openTestImage() {
        guard let testImage = UIImage(named: "customTextTest") else { return }
        viewController?.updateView(newImage: testImage)
    }
    
    // MARK: - UIViewController
    
    override func loadView() {
        model = TextRecognitionViewModel()
        model!.router = self
        viewController = TextRecognitionView(viewModel: model!)
        view = viewController
    }
}

extension TextRecognitionRouter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            viewController?.updateView(newImage: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
