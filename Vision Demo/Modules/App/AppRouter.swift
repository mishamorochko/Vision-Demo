import UIKit

final class AppRouter {

    // MARK: - Properties
    // MARK: Public
    // MARK: Private

    private let window: UIWindow

    // MARK: - Initializers

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - API

    func start() {
        let router = MainRouter()
        let navigationController = UINavigationController(rootViewController: router)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
