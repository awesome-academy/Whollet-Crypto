import Foundation

protocol CoinsRepository {
    func getCoins(params: CoinsRequestParams, completion: @escaping (CoinsResponseModel?, Error?) -> Void)
    
    func getCoinDetail(params: ChartRequestParams, completion: @escaping (ChartResponseModel?, Error?) -> Void)
    
    func getSearchCoin(params: SearchCoinRequestParams, completion: @escaping (SearchCoinResponseModel?, Error?) -> Void)
}
