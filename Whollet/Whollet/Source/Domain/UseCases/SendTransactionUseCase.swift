import Foundation
import ICONKit

final class SendTransactionUseCase {
    private let repository = WalletRepositoryImpl()
    
    func send(receivingAddress: String, amount: Double, wallet: Wallet, completion: @escaping (String?, Error?) -> Void) {
        return repository.sendTransaction(receivingAddress: receivingAddress, amount: amount, wallet: wallet, completion: completion)
    }
}
