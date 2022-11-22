import Foundation

final class GetSearchHistoryUseCase {
    private let repository = SearchHistoryRepositoryImpl()
    
    func get(completion: @escaping ([SearchCoinModel], Error?) -> (Void)) {
        repository.getSearchHistory(completion: completion)
    }
}
