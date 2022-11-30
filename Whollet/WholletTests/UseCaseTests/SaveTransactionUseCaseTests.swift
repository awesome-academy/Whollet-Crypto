@testable import Whollet
import XCTest

final class SaveTransactionUseCaseTests: XCTestCase {
    private let mockRepository = MockTransactionHistoryRepository()
    var useCase: SaveTransactionHistoryUseCase!

    override func setUp() {
        super.setUp()
        useCase = SaveTransactionHistoryUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.save(detail: TransactionDetail())
        XCTAssert(mockRepository.isSaveTransactionHistoryCalled)
    }
}
