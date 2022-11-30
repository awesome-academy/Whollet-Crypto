@testable import Whollet
import XCTest

final class GetICXBalanceUseCaseTests: XCTestCase {
    private let mockRepository = MockWalletRepository()
    var useCase: GetICXBalanceUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = GetICXBalanceUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.get(address: "")
        XCTAssert(mockRepository.isGetICXBalanceCalled)
    }
}
