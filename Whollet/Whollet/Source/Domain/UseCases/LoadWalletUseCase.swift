import Foundation
import ICONKit

final class LoadWalletUseCase {
    private let walletRepository = WalletRepositoryImpl()
    
    func load(key: String) -> Wallet {
        return walletRepository.getWalletFromPrivateKey(
            privateKey: key)
    }
}
