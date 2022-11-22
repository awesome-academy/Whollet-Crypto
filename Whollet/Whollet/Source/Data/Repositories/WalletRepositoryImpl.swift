import ICONKit
import BigInt

final class WalletRepositoryImpl: WalletRepository {
    let iconService = ICONService(provider: Endpoints.sdkURL, nid: Endpoints.sdkNid)
    
    func createWallet() -> Wallet {
        let wallet = Wallet(privateKey: nil)
        return wallet
    }
    
    func getWalletFromPrivateKey(privateKey: String) -> Wallet {
        let privateKey = PrivateKey(hex: Data(hex: privateKey))
        return Wallet(privateKey: privateKey)
    }
}
