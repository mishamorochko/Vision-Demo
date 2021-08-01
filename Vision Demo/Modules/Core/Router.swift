import Combine
import UIKit

protocol Router: AnyObject {

    func goToConfirmationAlert(title: String?, message: String?) -> AnyPublisher<Bool, Never>
    func close(animated: Bool, completion: (() -> Void)?)
}

extension Router {

    func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        close(animated: animated, completion: completion)
    }
}

extension Router where Self: UIViewController {

    func goToConfirmationAlert(title: String?, message: String?) -> AnyPublisher<Bool, Never> {
        Deferred { [weak self] in
            Future { future in
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(.init(title: "Yes", style: .default, handler: { _ in
                    future(.success(true))
                }))
                alert.addAction(.init(title: "No", style: .cancel, handler: { _ in
                    future(.success(false))
                }))
                self?.present(alert, animated: true, completion: nil)
            }
        }.eraseToAnyPublisher()
    }

    func close(animated: Bool, completion: (() -> Void)?) {
        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
            if animated, let completion = completion, let transitionCoordinator = transitionCoordinator {
                transitionCoordinator.animate(alongsideTransition: nil) { _ in
                    completion()
                }
            } else {
                completion?()
            }
        } else if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: animated, completion: completion)
        }
    }

    func push(_ router: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(router, animated: animated)
    }

    func present(_ router: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(router, animated: animated, completion: completion)
    }
}
