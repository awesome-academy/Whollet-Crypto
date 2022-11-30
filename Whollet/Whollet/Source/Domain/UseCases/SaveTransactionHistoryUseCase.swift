import Foundation

final class SaveTransactionHistoryUseCase {
    private let repository: TransactionHistoryRepository

    init(repository: TransactionHistoryRepository) {
        self.repository = repository
    }
    
    func save(detail: TransactionDetail) {
        return repository.saveTransactionHistory(detail: detail)
    }
}
