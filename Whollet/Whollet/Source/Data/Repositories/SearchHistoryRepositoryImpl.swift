import Foundation

final class SearchHistoryRepositoryImpl: SearchHistoryRepository {
    private let manager = LocalDataManager.shared
    
    func saveSearchHistory(_ search: SearchCoinModel) {
        manager.deleteSearch(search)
        manager.saveSearch(search)
    }

    func getSearchHistory(
        completion: @escaping ([SearchCoinModel], Error?) -> (Void)) {
        return manager.getSearchHistory(completion: completion)
    }
}
