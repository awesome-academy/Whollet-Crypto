import Foundation

final class SaveTransactionHistoryUseCase {
    private let repository = TransactionHistoryRepositoryImpl()
    
    func save(detail: TransactionDetail) {
        return repository.saveTransactionHistory(detail: detail)
    }
}
