import UIKit

final class MainRouter: UIViewController {

    // MARK: - Initialiers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension MainRouter: MainRouterProtocol {
    func goToTextRecognition() {
        let textRecognitionRouter = TextRecognitionRouter()
        push(textRecognitionRouter)
    }
}
