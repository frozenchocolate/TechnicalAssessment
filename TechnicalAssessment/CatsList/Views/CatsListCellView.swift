import UIKit
import Kingfisher

final class CatsListCellView: UICollectionViewCell {
    static let reuseIdentifier = "CatsListCellView"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 8, right: 0)
        view.alignment = .center
        view.spacing = 8
        [imageView, titleLabel].forEach(view.addArrangedSubview(_:))

        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()

        view.frame = .init(x: 0, y: 0, width: frame.size.width, height: 90)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.kf.indicatorType = .activity

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white.withAlphaComponent(0.3)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -8)
        ])

        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: CatsListCellViewModel) {
        titleLabel.text = model.breedName
        self.accessibilityIdentifier = titleLabel.text

        guard let url = model.imageURL
        else {
            imageView.image = UIImage(named: "placeholder.png")
            return
        }

        imageView.kf.setImage(with: url)
    }
}
