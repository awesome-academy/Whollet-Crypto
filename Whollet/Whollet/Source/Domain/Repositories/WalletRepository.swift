import ICONKit

protocol WalletRepository {
    func createWallet() -> Wallet
    func getWalletFromPrivateKey(privateKey: String) -> Wallet
    func getIcxBalance(address: String) -> String
    func sendTransaction(receivingAddress: String, amount: Double, wallet: Wallet, completion: @escaping (String?, Error?) -> Void)
    func getTransaction(txHash: String) -> Response.TransactionByHashResult?
}
