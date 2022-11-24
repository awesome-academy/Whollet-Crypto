import Foundation
import ICONKit

final class GetTransactionResultUseCase {
    private let repository = WalletRepositoryImpl()
    
    func get(txHash: String) -> Response.TransactionByHashResult? {
        return repository.getTransaction(txHash: txHash)
    }
}
