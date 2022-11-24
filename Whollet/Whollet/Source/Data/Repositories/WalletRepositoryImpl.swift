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
    
    func getIcxBalance(address: String) -> String {
        let result: Result<BigUInt, any Error> = iconService.getBalance(address: address).execute()
        switch result {
        case .success(let balance):
            return "\(balance)"
        case .failure(_):
            return "0"
        }
    }
    
    func sendTransaction(receivingAddress: String, amount: Double, wallet: Wallet, completion: @escaping (String?, Error?) -> Void) {
        let coinTransfer = Transaction()
            .from(wallet.address)
            .to(receivingAddress)
            .value(BigUInt(amount * AppConstants.CGFloats.toBigInt))
            .stepLimit(BigUInt(AppConstants.Ints.sendStepLimit))
            .nid(iconService.nid)
            .nonce(AppConstants.Strings.sendNonce)
        do {
            let signed = try SignedTransaction(transaction: coinTransfer, privateKey: wallet.key.privateKey)
            let request = iconService.sendTransaction(signedTransaction: signed)
            let response = request.execute()
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        } catch (let error) {
            completion(nil, error)
        }
    }
    
    func getTransaction(txHash: String) -> Response.TransactionByHashResult? {
        var transactionResult: Response.TransactionByHashResult?
        while transactionResult == nil {
            let request: Request<Response.TransactionByHashResult> = iconService.getTransaction(hash: txHash)
            let response = request.execute()
            switch response {
            case .success(let transaction):
                transactionResult = transaction
            case .failure (_):
                transactionResult = nil
            }
        }
        return transactionResult
    }
}
