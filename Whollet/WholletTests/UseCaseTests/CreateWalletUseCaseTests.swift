@testable import Whollet
import XCTest

final class CreateWalletUseCaseTests: XCTestCase {
    private let mockRepository = MockWalletRepository()
    var useCase: CreateWalletUseCase!
        
    override func setUp() {
        super.setUp()
        useCase = CreateWalletUseCase(walletRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.create()
        XCTAssert(mockRepository.isCreateWalletCalled)
    }
}
