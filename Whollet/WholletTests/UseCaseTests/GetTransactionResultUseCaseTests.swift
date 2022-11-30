@testable import Whollet
import XCTest

final class GetTransactionResultUseCaseTests: XCTestCase {
    private let mockRepository = MockWalletRepository()
    var useCase: GetTransactionResultUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = GetTransactionResultUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }
    
    func test_called() {
        useCase.get(txHash: "")
        XCTAssert(mockRepository.isGetTransactionResultCalled)
    }
}
