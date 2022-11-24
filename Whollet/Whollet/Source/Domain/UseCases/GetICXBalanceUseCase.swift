import Foundation

final class GetICXBalanceUseCase {
    private let repository = WalletRepositoryImpl()
    
    func get(address: String) -> String {
        return repository.getIcxBalance(address: address)
    }
}
