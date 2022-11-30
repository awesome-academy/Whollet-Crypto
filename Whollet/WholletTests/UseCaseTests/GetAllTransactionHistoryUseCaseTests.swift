@testable import Whollet
import XCTest

final class GetAllTransactionHistoryUseCaseTests: XCTestCase {
    private let mockRepository = MockTransactionHistoryRepository()
    var useCase: GetAllTransactionHistoryUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = GetAllTransactionHistoryUseCase(repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        useCase = nil
    }
    
    func test_called() {
        useCase.get { (data, error) -> Void in
        }
        XCTAssert(mockRepository.isGetAllTransactionHistoryCalled)
    }
    
    func test_success() {
        useCase.get {(data, error) -> Void in
            XCTAssert(error == nil)
            XCTAssertEqual(data?.count, 2)
        }
        mockRepository.getAllTransactionSuccess()
    }
    
    func test_failed() {
        useCase.get {(data, error) -> Void in
            XCTAssert(error != nil)
            XCTAssert(data == nil)
        }
        mockRepository.getAllTransactionFail(error: APIError.notModified)
    }
}
