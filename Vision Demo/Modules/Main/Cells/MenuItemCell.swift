import UIKit

final class MenuItemCell: UITableViewCell, ReusableView {

    // MARK: - Properties
    // MARK: Public

    // MARK: Private
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let disclosureIndicator = UIImageView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API
    
    func configure(using item: MenuItem) {
        titleLabel.text = item.title
        disclosureIndicator.image = item.image
    }

    // MARK: - Setups
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear

        disclosureIndicator.image = UIImage(systemName: "arrow.right")
        disclosureIndicator.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

        containerView.backgroundColor = AppColor.mainColor.uiColor
        containerView.layer.cornerRadius = 18
        containerView.layer.masksToBounds = true
    }

    private func addSubviews() {
        addSubviews(views: containerView, titleLabel, disclosureIndicator)
    }

    private func setupConstraints() {
        disclosureIndicator.pin.centerY(in: containerView).size(to: 28).trailing(to: containerView, offset: 16)
        titleLabel.pin.edges(.all, to: containerView, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        containerView.pin.edges(.all, to: self, insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)).height(to: 50)
    }
}
