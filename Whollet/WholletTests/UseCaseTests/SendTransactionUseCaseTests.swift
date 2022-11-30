@testable import Whollet
import XCTest
import ICONKit

final class SendTransactionUseCaseTests: XCTestCase {
    private let mockRepository = MockWalletRepository()
    var useCase: SendTransactionUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = SendTransactionUseCase(repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }

    func test_called() {
        useCase.send(
            receivingAddress: "",
            amount: 0.0,
            wallet: Wallet(privateKey: nil)) { _,_ in
            }
        XCTAssert(mockRepository.isSendTransactionCalled)
    }
    
    func test_success() {
        useCase.send(
            receivingAddress: "",
            amount: 0.0,
            wallet: Wallet(privateKey: nil)
        ) {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssert(data == "mockHash")
        }
        mockRepository.sendTransactionSuccess()
    }
    
    func test_failed() {
        useCase.send(
            receivingAddress: "",
            amount: 0.0,
            wallet: Wallet(privateKey: nil)
        ) {(data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == nil)
        }
        mockRepository.sendTransactionFail(error: APIError.notModified)
    }
}
