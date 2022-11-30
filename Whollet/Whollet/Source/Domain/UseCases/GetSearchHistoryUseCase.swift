import Foundation

final class GetSearchHistoryUseCase {
    private let repository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }
    
    func get(completion: @escaping ([SearchCoinModel], Error?) -> (Void)) {
        repository.getSearchHistory(completion: completion)
    }
}
