import ICONKit

protocol WalletRepository {
    func createWallet() -> Wallet
    func getWalletFromPrivateKey(privateKey: String) -> Wallet
}
