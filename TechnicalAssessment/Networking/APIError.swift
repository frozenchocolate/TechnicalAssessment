enum APIError: Error {
    case decoding
    case http(Int)
    case unknown
}
