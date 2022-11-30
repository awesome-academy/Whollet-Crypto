@testable import Whollet
import Foundation

final class MockTransactionHistoryRepository: TransactionHistoryRepository {
    var isSaveTransactionHistoryCalled = false
    var isGetAllTransactionHistoryCalled = false
    
    var completeGetAllTransactionHistoryClosure: (([TransactionDetail]?, Error?) -> ())!
    var completeGetAllTransactionHistory = [TransactionDetail(), TransactionDetail()]
    
    func saveTransactionHistory(detail: TransactionDetail) {
        isSaveTransactionHistoryCalled = true
    }
    
    func getAllTransactionHistory(completion: @escaping ([TransactionDetail]?, Error?) -> (Void)) {
        isGetAllTransactionHistoryCalled = true
        completeGetAllTransactionHistoryClosure = completion
    }
    
    func getAllTransactionSuccess() {
        completeGetAllTransactionHistoryClosure(completeGetAllTransactionHistory, nil)
    }
    
    func getAllTransactionFail(error: APIError?) {
        completeGetAllTransactionHistoryClosure(nil, error)
    }
}
