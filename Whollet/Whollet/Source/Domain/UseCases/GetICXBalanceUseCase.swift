import Foundation

final class GetICXBalanceUseCase {
    private let repository: WalletRepository
    
    init(repository: WalletRepository) {
        self.repository = repository
    }
    
    func get(address: String) -> String {
        return repository.getIcxBalance(address: address)
    }
}
