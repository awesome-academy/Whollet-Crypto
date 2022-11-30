import Foundation

final class AllTransactionViewModel: NSObject {
    private var getAllTransactionHistoryUseCase: GetAllTransactionHistoryUseCase!
    
    private(set) var bsTransactions: BehaviorSubject<[TransactionDetail]> = BehaviorSubject(nil)
    
    override init() {
        super.init()
        getAllTransactionHistoryUseCase = GetAllTransactionHistoryUseCase(repository: TransactionHistoryRepositoryImpl())
        getTransactions()
    }
    
    private func getTransactions() {
        getAllTransactionHistoryUseCase.get { [weak self] (data, error) -> (Void) in
            guard let self = self, error == nil, let data = data else { return }
            self.bsTransactions.add(data)
        }
    }
}
