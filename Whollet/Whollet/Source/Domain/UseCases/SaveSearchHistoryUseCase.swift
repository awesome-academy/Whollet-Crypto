import Foundation

final class SaveSearchCoinUseCase {
    private let repository = SearchHistoryRepositoryImpl()
    
    func save(_ search: SearchCoinModel) {
        repository.saveSearchHistory(search)
    }
}
