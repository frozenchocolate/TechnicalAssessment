struct CatBreed: Decodable {
    let name: String
    let image: BreedImage?
    let energyLevel: Int
    let temperament: String
}
