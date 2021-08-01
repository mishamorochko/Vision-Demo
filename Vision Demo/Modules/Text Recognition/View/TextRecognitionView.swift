import UIKit

final class TextRecognitionView: UIView {

    // MARK: - Properties
    // MARK: Private

    private let viewModel: TextRecognitionViewModel

    private let textLabel = UILabel()

    // MARK: - Initializers

    init(viewModel: TextRecognitionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setup() {
        setupUI()
        addSubviews()
        setupConstraints()
    }

    private func setupUI() {
        backgroundColor = UIColor(named: "SecondColor")
        textLabel.text = "Text Recognition Module"
    }

    private func addSubviews() {
        addSubviews(views: textLabel)
    }

    private func setupConstraints() {
        textLabel.pin.center(in: self)
    }
}
