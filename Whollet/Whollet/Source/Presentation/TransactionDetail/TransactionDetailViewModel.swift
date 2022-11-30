import Foundation
import ICONKit
        
final class TransactionDetailViewModel: NSObject {
    private var sendTransactionUseCase: SendTransactionUseCase!
    private var getTransactionResultUseCase: GetTransactionResultUseCase!
    private var saveTransactionHistoryUseCase: SaveTransactionHistoryUseCase!
    private(set) var bsHash: BehaviorSubject<String> = BehaviorSubject(nil)
    private(set) var bsResult: BehaviorSubject<Response.TransactionByHashResult> = BehaviorSubject(nil)
    
    override init() {
        super.init()
        self.sendTransactionUseCase = SendTransactionUseCase(repository: WalletRepositoryImpl())
        self.getTransactionResultUseCase = GetTransactionResultUseCase(repository: WalletRepositoryImpl())
        self.saveTransactionHistoryUseCase = SaveTransactionHistoryUseCase(repository: TransactionHistoryRepositoryImpl())
    }
    
    func sendICX(to: String, amount: Double, wallet: Wallet) {
        sendTransactionUseCase.send(
            receivingAddress: to,
            amount: amount,
            wallet: wallet) { [weak self] (result, error) -> Void in
            guard let self = self, error == nil, let result = result else { return }
            self.bsHash.add(result)
        }
    }
    
    func getTransaction(txHash: String) {
        bsResult.add(getTransactionResultUseCase.get(txHash: txHash))
    }
    
    func saveTransaction(detail: TransactionDetail) {
        saveTransactionHistoryUseCase.save(detail: detail)
    }
}
