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
        visionTest()
    }

    private func setupUI() {
        backgroundColor = UIColor(named: "SecondColor")
        textLabel.text = "Text Recognition Module"
    }

    private func addSubviews() {
        addSubviews(views: textLabel)
    }

    private func setupConstraints() {
        textLabel.pin.centerY(in: self).edges([.left, .right], to: self, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textLabel.numberOfLines = 0
    }

    // MARK: = Helpers
    private func visionTest() {
        guard let image = UIImage(named: "handwritten") else { return }
        CoreVisionManager.instance.recognizeTextFrom(image: image) { [weak self] recognizedText in
            guard let view = self else { return }
            view.textLabel.text = recognizedText
        }
    }
}
