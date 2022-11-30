@testable import Whollet
import XCTest

final class GetChartUseCaseTests: XCTestCase {
    private let mockRepository = MockCoinsRepository()
    var useCase: GetChartlUseCase!
    let params = ChartRequestParams(
        id: "btc",
        day: 30,
        interval: "daily")
    
    override func setUp() {
        super.setUp()
        useCase = GetChartlUseCase(coinsRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }
    
    func test_called() {
        useCase.getDetailChart(params: params) {(_, __) -> Void in
        }
        XCTAssert(mockRepository.isGetCoinDetailCalled)
    }
    
    func test_success() {
        useCase.getDetailChart(params: params) {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssertEqual(data?.prices.count, 2)
        }
        mockRepository.getCoinDetailSuccess()
    }
    
    func test_failed() {
        useCase.getDetailChart(params: params) {(data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == nil)
        }
        mockRepository.getCoinDetailFail(error: APIError.notModified)
    }
}
