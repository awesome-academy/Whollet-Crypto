@testable import Whollet
import Foundation

final class MockCoinsRepository: CoinsRepository {
    var isGetCoinsCalled = false
    var isGetCoinDetailCalled = false
    var isGetSeachCoinCalled = false
    
    var completeGetCoinsClosure: ((CoinsResponseModel?, Error?) -> ())!
    var completeGetCoins: CoinsResponseModel = [CoinModel(), CoinModel()]
    
    var completeGetDetailClosure: ((ChartResponseModel?, Error?) -> ())!
    var completeGetDetailCoins: ChartResponseModel = ChartModel(prices: [[2.0, 3.0], [2.0, 3.0]])
    
    var completeGetSearchClosure: ((SearchCoinResponseModel?, Error?) -> ())!
    var completeGetSearch: SearchCoinResponseModel = SearchCoinResponseModel(coins: [SearchCoinModel(), SearchCoinModel()])
    
    func getCoins(params: CoinsRequestParams, completion: @escaping (CoinsResponseModel?, Error?) -> Void) {
        isGetCoinsCalled = true
        completeGetCoinsClosure = completion
    }
    
    func getCoinsSuccess() {
        completeGetCoinsClosure(completeGetCoins, nil)
    }
    
    func getCoinsFail(error: APIError?) {
        completeGetCoinsClosure(nil, error)
    }
    
    func getCoinDetail(params: ChartRequestParams, completion: @escaping (ChartResponseModel?, Error?) -> Void) {
        isGetCoinDetailCalled = true
        completeGetDetailClosure = completion
    }
    
    func getCoinDetailSuccess() {
        completeGetDetailClosure(completeGetDetailCoins, nil)
    }
    
    func getCoinDetailFail(error: APIError?) {
        completeGetDetailClosure(nil, error)
    }
    
    func getSearchCoin(params: SearchCoinRequestParams, completion: @escaping (SearchCoinResponseModel?, Error?) -> Void) {
        isGetSeachCoinCalled = true
        completeGetSearchClosure = completion
    }
    func getSearchSuccess() {
        completeGetSearchClosure(completeGetSearch, nil)
    }
    
    func getSearchFail(error: APIError?) {
        completeGetSearchClosure(nil, error)
    }
}
