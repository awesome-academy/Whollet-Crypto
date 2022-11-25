import Foundation

final class GetAllTransactionUseCase {
    private let repository = TransactionHistoryRepositoryImpl()
    
    func get(completion: @escaping ([TransactionDetail]?, Error?) -> Void) {
        return repository.getAllTransactionHistory(completion: completion)
    }
}
