import UIKit

final class CatsListDataSource: NSObject {
    var list = [CatBreed]()

    let onBreedSelected: ((CatBreed) -> Void)?

    init(with list: [CatBreed], onBreedSelected: @escaping ((CatBreed) -> Void)) {
        self.list = list
        self.onBreedSelected = onBreedSelected
    }
}

extension CatsListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { list.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatsListCellView.reuseIdentifier, for: indexPath) as? CatsListCellView
            else { return UICollectionViewCell() }

        let item = list[indexPath.row]
        cell.configure(with: .init(breedName: item.name, imageURL: item.image?.url))

        return cell
    }
}

extension CatsListDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onBreedSelected?(list[indexPath.item])
    }
}
