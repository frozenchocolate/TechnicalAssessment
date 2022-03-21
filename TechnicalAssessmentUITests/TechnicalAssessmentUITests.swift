import XCTest

class TechnicalAssessmentUITests: XCTestCase {

    let app = XCUIApplication()
    private let testTimeout: TimeInterval = 5

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        Thread.sleep(forTimeInterval: testTimeout)
    }

    func testCollectionViewNotEmpty() throws {
        XCTAssertGreaterThan(app.cells.count, 0)
    }

    func testDetailView() throws {
        let firstCell = app.cells.firstMatch
        let identifier = firstCell.identifier

        firstCell.tap()

        Thread.sleep(forTimeInterval: 1)

        XCTAssert(app.staticTexts[identifier].exists)
    }
}

