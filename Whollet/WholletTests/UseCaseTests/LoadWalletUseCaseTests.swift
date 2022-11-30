@testable import Whollet
import XCTest

final class LoadWalletUseCaseTests: XCTestCase {
    private let mockRepository = MockWalletRepository()
    var useCase: LoadWalletUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = LoadWalletUseCase(walletRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.load(key: "")
        XCTAssert(mockRepository.isLoadWalletCalled)
    }
}
