import UIKit

final class TextRecognitionRouter: UIViewController {
    
    // MARK: - Properties
    // MARK: - Public
    
    var model: TextRecognitionViewModel?
    
    // MARK: Private
    
    private let imagePicker = ImagePickerRouter()
    
    // MARK: - Initialiers
    
    init() {
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
        #if DEBUG
        print("TextRecognitionRouter deinit")
        #endif
    }
    
    // MARK: - UIViewController
    
    override func loadView() {
        model = TextRecognitionViewModel()
        model!.router = self
        let recognitionView = TextRecognitionView(viewModel: model!)
        view = recognitionView
    }
    
    // MARK: - Helpers
    
    private func openTestImage(selectedImageCompletion: @escaping ((UIImage) -> Void)) {
        guard let testImage = UIImage(named: "customTextTest") else { return }
        selectedImageCompletion(testImage)
    }
}

extension TextRecognitionRouter: TextRecognitionRouterProtocol {
    func actionForChoosedType(_ type: TextRecognitionRouteType, selectedImageCompletion: @escaping ((UIImage) -> Void)) {
        switch type {
        case .camera: imagePicker.showCamera(on: self, selectedImageCompletion: selectedImageCompletion)
        case .gallery: imagePicker.showGallery(on: self, selectedImageCompletion: selectedImageCompletion)
        case .testImage: openTestImage(selectedImageCompletion: selectedImageCompletion)
        }
    }
    
    func presentImageActionSheet(actionSheet: UIAlertController) {
        present(actionSheet)
    }
}


