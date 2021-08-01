import UIKit

final class MainView: UIView {

    // MARK: - Properties
    // MARK: Private

    private let viewModel: MainViewModel
    private let tableView = UITableView()
    
    // MARK: - Initializers
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.becomeActive()
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setup() {
        addSubviews()
        setupConstraints()
        setupTableView()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "SecondColor")
    }
    
    private func addSubviews() {
        addSubviews(views: tableView)
    }
    
    private func setupConstraints() {
        tableView.pin.edges(.all, to: self, insets: .zero)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemCell.self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuItemCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(using: viewModel.mainMenuItems[indexPath.row])
        return cell
    }
}
