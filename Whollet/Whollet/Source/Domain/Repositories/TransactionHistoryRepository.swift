import Foundation

protocol TransactionHistoryRepository {
    func saveTransactionHistory(detail: TransactionDetail)
    func getAllTransactionHistory(completion: @escaping ([TransactionDetail]?, Error?) -> (Void))
}
