import UIKit

class MainCoordinator {

    deinit {
        debugPrint("MainCoordinator deinit")
        onDeinit?()
    }

    var onDeinit: (() -> Void)?
    private let configuration: APIConfiguration
    private var navigationController: UINavigationController?

    init?() {
        guard
            let testURL: String = Bundle.infoPlistValue(forKey: "testBaseURL"),
            let liveURL: String = Bundle.infoPlistValue(forKey: "liveBaseURL"),
            let APIKey: String = Bundle.infoPlistValue(forKey: "APIKey")
        else {
            return nil
        }
        self.configuration = APIConfiguration(liveBaseURL: liveURL, testBaseURL: testURL, APIKey: APIKey)
    }

    func start() -> UIViewController {

        let catsListVM = CatsListViewModel(with: configuration)
        let catsListVC = CatsListViewController(viewModel: catsListVM)

        catsListVM.onBreedSelected = { [weak self] breed in
            self?.showDetail(from: breed)
        }

        let navigationController = UINavigationController(rootViewController: catsListVC)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white

        self.navigationController = navigationController

        return navigationController
    }

    func showDetail(from selectedBreed: CatBreed) {

        let catsDetailVC = CatDetailViewController(viewModel: CatDetailViewModel(with: selectedBreed))

        navigationController?.pushViewController(catsDetailVC, animated: true)
    }
}
