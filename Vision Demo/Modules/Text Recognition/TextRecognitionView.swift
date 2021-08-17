import UIKit

protocol TextRecognitionViewProtocol: UIView {}

final class TextRecognitionView: UIView, TextRecognitionViewProtocol {

    // MARK: - Properties
    // MARK: Private

    private let viewModel: TextRecognitionViewModel
    private let importOrTakeImageButton = UIButton()
    private let selectedImageView = UIImageView()
    private let resultTextView = UITextView()
    private let coreVisionManager = CoreVisionManager()

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

        selectedImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        resultTextView.pin.below(of: selectedImageView, offset: 12).above(of: importOrTakeImageButton, offset: 16).leading(to: self, offset: 16).trailing(to: self, offset: 16)
    }

    // MARK: - Helpers

    private func updateImage(newImage: UIImage) {
        selectedImageView.image = newImage
        coreVisionManager.recognizeTextFrom(image: newImage) { result in
            self.resultTextView.text = result
        }
    }

    @objc private func selectImageDidTapped() {
        let actionSheet = UIAlertController(title: "Choose image from:", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.viewModel.openImagePickerAction(for: .camera) { selectedImage in
                self.updateImage(newImage: selectedImage)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.viewModel.openImagePickerAction(for: .gallery) { selectedImage in
                self.updateImage(newImage: selectedImage)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Test image", style: .default, handler: { _ in
            self.viewModel.openImagePickerAction(for: .testImage) { selectedImage in
                self.updateImage(newImage: selectedImage)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewModel.present(actionSheet: actionSheet)
    }
}
