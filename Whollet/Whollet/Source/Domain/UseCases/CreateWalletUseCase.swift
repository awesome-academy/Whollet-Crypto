import Foundation
import ICONKit

final class CreateWalletUseCase {
    private let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }
    
    func create() -> Wallet {
        return walletRepository.createWallet()
    }
}
