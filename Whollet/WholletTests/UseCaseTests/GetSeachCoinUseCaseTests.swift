@testable import Whollet
import XCTest

final class GetSeachCoinUseCaseTests: XCTestCase {
    private let mockRepository = MockCoinsRepository()
    var useCase: GetSearchCoinUseCase!
    let params = SearchCoinRequestParams(query: "abc")
    
    
    override func setUp() {
        super.setUp()
        useCase = GetSearchCoinUseCase(coinsRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.getSearchCoin(params: params) {(_, __) -> Void in
        }
        XCTAssert(mockRepository.isGetSeachCoinCalled)
    }
    
    func test_success() {
        useCase.getSearchCoin(params: params) {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssertEqual(data?.coins?.count, 2)
        }
        mockRepository.getSearchSuccess()
    }
    
    func test_failed() {
        useCase.getSearchCoin(params: params) {(data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == nil)
        }
        mockRepository.getSearchFail(error: APIError.notModified)
    }
}
