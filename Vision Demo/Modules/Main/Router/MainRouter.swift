import UIKit

final class MainRouter: UIViewController {

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
    }

    // MARK: - UIViewController

    override func loadView() {
        let model = MainViewModel()
        model.router = self
        view = MainView(viewModel: model)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Vision Demo"
    }
}

extension MainRouter: MainRouterInput {
    func goToTextRecognition() {
        let textRecognitionRouter = TextRecognitionRouter()
        push(textRecognitionRouter)
    }
}
