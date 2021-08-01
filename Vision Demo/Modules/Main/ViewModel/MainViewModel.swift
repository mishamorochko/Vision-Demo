import UIKit

final class MainViewModel {

    // MARK: - Inner Types

    // MARK: - Properties
    // MARK: Public

    weak var router: MainRouterInput?

    var itemsCount: Int {
        menuItems.count
    }

    var mainMenuItems: [MenuItem] {
        menuItems
    }

    // MARK: Private

    private var menuItems = [MenuItem]()

    // MARK: - Initializers

    init() {}

    // MARK: - API

    func becomeActive() {}

    func initMenuModels() {
        menuItems.append(MenuItem(title: "Text Recognition", image: UIImage(systemName: "rectangle.and.text.magnifyingglass") ?? UIImage(), type: .textRecognition))
        menuItems.append(MenuItem(title: "Face Detection", image: UIImage(systemName: "faceid") ?? UIImage(), type: .faceDetection))
        menuItems.append(MenuItem(title: "Object tracking", image: UIImage(systemName: "person.fill.viewfinder") ?? UIImage(), type: .objectTracking))
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let router = router else { return }
        switch menuItems[indexPath.row].type {
        case .textRecognition: router.goToTextRecognition()
        case .faceDetection, .objectTracking: break
        }
    }
}
