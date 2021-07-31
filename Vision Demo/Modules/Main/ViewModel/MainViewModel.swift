import Foundation

final class MainViewModel: ObservableObject {

    // MARK: - Properties
    // MARK: Public

    weak var router: MainRouter?

    // MARK: Private

    // MARK: - Initializers

    init() {}

    // MARK: - API

    func becomeActive() {}
}
