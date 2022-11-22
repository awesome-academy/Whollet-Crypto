import Foundation
import ICONKit

final class CreateWalletUseCase {
    private let walletRepository = WalletRepositoryImpl()
    
    func create() -> Wallet {
        return walletRepository.createWallet()
    }
}
