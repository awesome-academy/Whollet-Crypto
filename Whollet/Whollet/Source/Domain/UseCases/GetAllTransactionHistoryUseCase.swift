import Foundation

final class GetAllTransactionHistoryUseCase {
    private let repository: TransactionHistoryRepository
    
    init(repository: TransactionHistoryRepository) {
        self.repository = repository
    }
    
    func get(completion: @escaping ([TransactionDetail]?, Error?) -> Void) {
        return repository.getAllTransactionHistory(completion: completion)
    }
}
