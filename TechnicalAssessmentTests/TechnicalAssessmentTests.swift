import XCTest
import Combine
import UIKit

@testable import TechnicalAssessment

class TechnicalAssessmentTests: XCTestCase {

    private var cancellable: AnyCancellable?
    private let testTimeout: TimeInterval = 5
    private var mainCoordinator: MainCoordinator?

    private var configuration: APIConfiguration? {
        guard
            let testURL: String = Bundle.infoPlistValue(forKey: "testBaseURL"),
            let liveURL: String = Bundle.infoPlistValue(forKey: "liveBaseURL"),
            let APIKey: String = Bundle.infoPlistValue(forKey: "APIKey")
        else {
            return nil
        }
        return .init(liveBaseURL: liveURL, testBaseURL: testURL, APIKey: APIKey)
    }

    func testAPIRequest() throws {
        guard let configuration = configuration else {
            XCTFail("Configuration failure")

            return
        }

        let requestBuilder = RequestBuilder(confiuration: configuration)

        let publisher: AnyPublisher<[CatBreed], APIError> = APIClient().request(with: requestBuilder.buildUrlRequest(from: .breedsList(1)))

        let expectation = self.expectation(description: "Performing API request")

        cancellable = publisher.sink(receiveCompletion: { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .failure(let error):
                    XCTFail("Failed to load cat breeds.\nReason:\(error.localizedDescription)")
                case .finished:
                    break
            }
            self.cancellable = nil
        }) { data in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
