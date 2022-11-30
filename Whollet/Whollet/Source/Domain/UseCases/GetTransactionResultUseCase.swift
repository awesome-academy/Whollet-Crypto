import Foundation
import ICONKit

final class GetTransactionResultUseCase {
    private let repository: WalletRepository
    
    init(repository: WalletRepository) {
        self.repository = repository
    }
    
    func get(txHash: String) -> Response.TransactionByHashResult? {
        return repository.getTransaction(txHash: txHash)
    }
}
