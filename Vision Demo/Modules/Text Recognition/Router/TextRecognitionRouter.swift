import UIKit

final class TextRecognitionRouter: UIViewController, TextRecognitionRouterInput {

    // MARK: - Properties
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

    deinit {
        completion?()
        #if DEBUG
        print("TextRecognitionRouter deinit")
        #endif
    }

    // MARK: - UIViewController

    override func loadView() {
        let model = TextRecognitionViewModel()
        model.router = self
        view = TextRecognitionView(viewModel: model)
    }
}
