import Combine

class CatsListViewModel: ServiceType {

    let requestBuilder: RequestBuilder
    let client: APIClient = APIClient()
    private var cancellable: AnyCancellable?

    var onBreedSelected: ((CatBreed) -> Void)?

    init(with configuration: APIConfiguration) {
        self.requestBuilder = RequestBuilder(confiuration: configuration)
    }

    func getCatsList() -> AnyPublisher<[CatBreed], APIError> {
        return client.request(with: requestBuilder.buildUrlRequest(from: .breedsList(1)))
            .eraseToAnyPublisher()
    }
}
