import UIKit

final class TextRecognitionRouter: UIViewController {
    
    // MARK: - Properties
    // MARK: - Public
    
    var model: TextRecognitionViewModel?
    var viewController: TextRecognitionViewInput?
    
    // MARK: Private
    
    private let completion: (() -> Void)?
    
    // MARK: - Initialiers
    
    init(completion: (() -> Void)? = nil) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    deinit {
        completion?()
        #if DEBUG
        print("TextRecognitionRouter deinit")
        #endif
    }
    
    // MARK: - UIViewController
    
    override func loadView() {
        model = TextRecognitionViewModel()
        model!.router = self
        viewController = TextRecognitionView(viewModel: model!)
        view = viewController
    }
    
    // MARK: - Helpers
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openTestImage() {
        guard let testImage = UIImage(named: "customTextTest") else { return }
        viewController?.updateView(newImage: testImage)
    }
}

extension TextRecognitionRouter: TextRecognitionRouterInput {
    func actionForChoosedType(_ type: TextRecognitionRouteType) {
        switch type {
        case .camera: openCamera()
        case .gallery: openGallery()
        case .testImage: openTestImage()
        }
    }
    
    func presentImageActionSheet(actionSheet: UIAlertController) {
        present(actionSheet)
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
