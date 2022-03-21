import UIKit
import Combine

final class CatsListViewController: UIViewController, ViewControllerType {

    typealias ServiceType = CatsListViewModel

    var viewModel: CatsListViewModel

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlDidRefresh), for: .valueChanged)
        return control
    }()

    private var cancellable: AnyCancellable?

    private lazy var dataSource: CatsListDataSource = {
        let dataSource = CatsListDataSource(with: [], onBreedSelected: { [weak self] breed in
            self?.viewModel.onBreedSelected?(breed)
        })

        return dataSource
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: (view.frame.size.width - 72) / 3, height: 140)

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CatsListCellView.self, forCellWithReuseIdentifier: CatsListCellView.reuseIdentifier)

        view.dataSource = dataSource
        view.delegate = dataSource

        return view
    }()

    required init(viewModel: CatsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cats!!!"

        view.backgroundColor = .systemTeal

        setupUI()
        reloadData()
    }

    private func reloadData() {
        cancellable = viewModel.getCatsList()
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self else { return }

                self.refreshControl.endRefreshing()
                switch result {
                    case .failure(let error):
                        print("Handle error: \(error)")
                    case .finished:
                        break
                }
                self.cancellable = nil
            }) { data in
                self.dataSource.list = data
                self.collectionView.reloadData()
            }
    }

    private func setupUI() {
        collectionView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func refreshControlDidRefresh() {
        reloadData()
    }
}
