import Foundation
import ICONKit

final class LoadWalletUseCase {
    private let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }
    
    func load(key: String) -> Wallet {
        return walletRepository.getWalletFromPrivateKey(
            privateKey: key)
    }
}
