import UIKit

final class TextRecognitionView: UIView, TextRecognitionViewInput {

    // MARK: - Properties
    // MARK: Private

    private let viewModel: TextRecognitionViewModel
    private let importOrTakeImageButton = UIButton()
    private let selectedImageView = UIImageView()
    private let resultTextView = UITextView()

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
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        importOrTakeImageButton.layer.cornerRadius = importOrTakeImageButton.frame.size.height / 2
    }

    // MARK: - Setups
    
    func updateView(newImage: UIImage) {
        selectedImageView.image = newImage
        CoreVisionManager.instance.recognizeTextFrom(image: newImage) { result in
            self.resultTextView.text = result
        }
    }
    
    private func setup() {
        setupUI()
        addSubviews()
        setupConstraints()
    }

    private func setupUI() {
        backgroundColor = AppColor.secondaryColor.uiColor
        importOrTakeImageButton.setTitle("Select image", for: .normal)
        importOrTakeImageButton.backgroundColor = .systemBlue
        
        resultTextView.layer.cornerRadius = 12
        resultTextView.backgroundColor = AppColor.mainColor.uiColor
        resultTextView.isEditable = false
        resultTextView.font = .systemFont(ofSize: 14, weight: .regular)
        
        guard let image = UIImage(systemName: "photo") else { return }
        selectedImageView.image = image
        selectedImageView.contentMode = .scaleAspectFit
        
        importOrTakeImageButton.addTarget(self, action: #selector(selectImageDidTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        addSubviews(views: importOrTakeImageButton, selectedImageView, resultTextView)
    }

    private func setupConstraints() {
        importOrTakeImageButton.pin.bottom(to: self, offset: 42).size(to: CGSize(width: 210, height: 42)).centerX(in: self)
        selectedImageView.pin.leading(to: self, offset: 16).trailing(to: self, offset: 16).height(to: 280)
        
        selectedImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        resultTextView.pin.below(of: selectedImageView, offset: 12).above(of: importOrTakeImageButton, offset: 16).leading(to: self, offset: 16).trailing(to: self, offset: 16)
    }

    // MARK: - Helpers
    
    @objc private func selectImageDidTapped() {
        viewModel.chooseImage()
    }
}
