@testable import Whollet
import XCTest

final class GetSearchHistoryUseCaseTests: XCTestCase {
    private let mockRepository = MockSearchHistoryRepository()
    var useCase: GetSearchHistoryUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = GetSearchHistoryUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.get { (data, error) -> Void in
        }
        XCTAssert(mockRepository.isGetSearchHistoryCalled)
    }
    
    func test_success() {
        useCase.get {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssertEqual(data.count, 2)
        }
        mockRepository.getSearchSuccess()
    }
    
    func test_failed() {
        useCase.get { [weak self] (data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == [])
        }
        mockRepository.getSearchFail(error: APIError.notModified)
    }
}
