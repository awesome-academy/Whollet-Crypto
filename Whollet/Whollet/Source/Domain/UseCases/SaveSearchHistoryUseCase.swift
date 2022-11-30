import Foundation

final class SaveSearchHistoryUseCase {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func save(_ search: SearchCoinModel) {
        repository.saveSearchHistory(search)
    }
}
