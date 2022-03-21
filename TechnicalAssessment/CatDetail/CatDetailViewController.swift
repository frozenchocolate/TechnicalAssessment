import UIKit
import SwiftUI

final class CatDetailViewController: UIViewController, ViewControllerType {

    typealias ServiceType = CatDetailViewModel

    var viewModel: CatDetailViewModel

    private let stackView: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        view.alignment = .leading
        view.spacing = 8

        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()

        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.kf.indicatorType = .activity
        view.layer.cornerRadius = 4

        return view
    }()

    init(viewModel: CatDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = viewModel.breedName

        view.backgroundColor = .systemTeal

        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])

        var labels = [UIView]()
        labels.append(contentsOf: makeLabels(title: "Breed:", text: viewModel.breedName))
        labels.append(contentsOf: makeLabels(title: "Temperament:", text: viewModel.temperament))
        labels.append(contentsOf: makeLabels(title: "Energy Level:", text: "\(viewModel.energyLevel)"))

        labels.forEach(stackView.addArrangedSubview(_:))
        stackView.addArrangedSubview(UIView())

        guard let imageURL = viewModel.imageURL else {
            imageView.image = UIImage(named: "placeholder.png")
            return
        }

        imageView.kf.setImage(with: imageURL)
    }

    private func makeLabels(title: String, text: String) -> [UIView] {
        [makeLabel(title: true, text: title), makeLabel(title: false, text: text)]
    }

    private func makeLabel(title: Bool, text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = title ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .white

        return label
    }
}
