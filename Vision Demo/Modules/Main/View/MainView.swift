import UIKit

final class MainView: UIView {

    // MARK: - Properties
    // MARK: Private

    private let viewModel: MainViewModel

    // MARK: - Initializers

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setup() {}
}
