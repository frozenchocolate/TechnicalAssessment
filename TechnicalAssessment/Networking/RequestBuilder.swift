import Foundation

struct RequestBuilder {

    private let confiuration: APIConfiguration

    init(confiuration: APIConfiguration) {
        self.confiuration = confiuration
    }

    enum RequestEndpoint {
        case breedsList(Int)

        var url: String {
            switch self {
                case .breedsList(let version):
                    return "v\(version)/breeds"
            }
        }
    }

    func buildUrlRequest(from endpoint: RequestEndpoint) -> URLRequest {
        guard
            let url = URL(string: "\(confiuration.baseURL)/\(endpoint.url)")
        else { preconditionFailure("Invalid URL format") }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["x-api-key": confiuration.APIKey]
        return request
    }
}
