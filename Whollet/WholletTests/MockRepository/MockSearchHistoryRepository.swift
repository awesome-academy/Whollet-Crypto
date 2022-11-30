@testable import Whollet
import Foundation

final class MockSearchHistoryRepository: SearchHistoryRepository {
    var isSaveSearchHistoryCalled = false
    var isGetSearchHistoryCalled = false
    
    var completeGetSearchHistoryClosure: (([SearchCoinModel], Error?) -> ())!
    var completeGetSearchHistory = [SearchCoinModel(), SearchCoinModel()]
    
    func saveSearchHistory(_ search: SearchCoinModel) {
        isSaveSearchHistoryCalled = true
    }
    
    func getSearchHistory(completion: @escaping ([SearchCoinModel], Error?) -> (Void)) {
        isGetSearchHistoryCalled = true
        completeGetSearchHistoryClosure = completion
    }
    
    func getSearchSuccess() {
        completeGetSearchHistoryClosure(completeGetSearchHistory, nil)
    }
    
    func getSearchFail(error: APIError?) {
        completeGetSearchHistoryClosure([], error)
    }
}
