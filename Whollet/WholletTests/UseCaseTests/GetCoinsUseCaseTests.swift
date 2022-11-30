@testable import Whollet
import XCTest

final class GetCoinsUseCaseTests: XCTestCase {
    private let mockRepository = MockCoinsRepository()
    var useCase: GetCoinsUseCase!
    let params = CoinsRequestParams(
        order: "market_cap_desc",
        perPage: 10,
        page: 1,
        sparkline: false,
        ids: nil)
    
    override func setUp() {
        super.setUp()
        useCase = GetCoinsUseCase(coinsRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.getCoins(params: params) {(_, __) -> Void in
        }
        XCTAssert(mockRepository.isGetCoinsCalled)
    }
    
    func test_success() {
        useCase.getCoins(params: params) {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssertEqual(data?.count, 2)
        }
        mockRepository.getCoinsSuccess()
    }
    
    func test_failed() {
        useCase.getCoins(params: params) {(data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == nil)
        }
        mockRepository.getCoinsFail(error: APIError.notModified)
    }
}
