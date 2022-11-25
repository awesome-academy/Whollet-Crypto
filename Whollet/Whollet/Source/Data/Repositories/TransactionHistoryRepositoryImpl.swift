import ICONKit

final class TransactionHistoryRepositoryImpl: TransactionHistoryRepository {
    private let manager = LocalDataManager.shared
    
    func saveTransactionHistory(detail: TransactionDetail) {
        manager.saveTransactionHistory(detail)
    }
    
    func getAllTransactionHistory(completion: @escaping ([TransactionDetail]?, Error?) -> Void) {
        return manager.getAllTransactionHistory(completion: completion)
    }
}
