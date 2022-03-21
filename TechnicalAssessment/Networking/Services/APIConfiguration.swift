struct APIConfiguration {
    private let liveBaseURL: String
    private let testBaseURL: String
    let APIKey: String

    init(
        liveBaseURL: String,
        testBaseURL: String,
        APIKey: String
    ) {
        self.liveBaseURL = liveBaseURL
        self.testBaseURL = testBaseURL
        self.APIKey = APIKey
    }

    var baseURL: String {
        #if DEBUG
        return testBaseURL
        #else
        return liveBaseURL
        #endif
    }
}
