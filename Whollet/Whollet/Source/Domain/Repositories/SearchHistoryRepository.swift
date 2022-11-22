import Foundation

protocol SearchHistoryRepository {
    func saveSearchHistory(_ search: SearchCoinModel)
    func getSearchHistory(
        completion: @escaping ([SearchCoinModel], Error?) -> (Void))
}
