@testable import Whollet
import XCTest

final class SaveSearchHistoryUseCaseTests: XCTestCase {
    private let mockRepository = MockSearchHistoryRepository()
    var useCase: SaveSearchHistoryUseCase!
    let search = SearchCoinModel()
    
    override func setUp() {
        super.setUp()
        useCase = SaveSearchHistoryUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.save(search)
        XCTAssert(mockRepository.isSaveSearchHistoryCalled)
    }
}
