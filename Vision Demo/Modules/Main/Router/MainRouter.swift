import UIKit

protocol MainRouter: AnyObject {}

final class MainRouterImplementation: UIViewController, MainRouter {

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
        view = MainView(viewModel: model)
    }

    // MARK: - API
}
