import Foundation
import Combine
import UIKit

struct APIClient {

    func request<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, APIError> {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {

                    return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError { error in
                            debugPrint(error)
                            return .decoding
                        }
                        .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.http(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: .unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func loadImage(with url: String) -> AnyPublisher<UIImage, APIError> {
        guard let url = URL(string: url)
            else {
                return Fail(error: .decoding)
                    .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<UIImage, APIError> in
                if let image = UIImage(data: data) {
                    return Just(image)
                        .mapError {_ in .decoding }
                        .eraseToAnyPublisher()
                }
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

    }
}
