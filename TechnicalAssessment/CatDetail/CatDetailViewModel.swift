import Foundation
struct CatDetailViewModel {
    let temperament: String
    let energyLevel: Int
    let breedName: String
    let imageURL: URL?

    init(with breed: CatBreed) {
        self.breedName = breed.name
        self.temperament = breed.temperament
        self.energyLevel = breed.energyLevel
        self.imageURL = breed.image?.url
    }
}
