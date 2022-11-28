import Foundation

final class GetAllTransactionHistoryUseCase {
    private let repository = TransactionHistoryRepositoryImpl()
    
    func get(completion: @escaping ([TransactionDetail]?, Error?) -> Void) {
        return repository.getAllTransactionHistory(completion: completion)
    }
}
