import Foundation

final class CoinServices {
    static let shared = CoinServices()
    
    private init() {}
    
    private let API = APICaller.shared
    
    func getCoins(
        request params: CoinsRequestParams,
        completion: @escaping(Result<CoinsResponseModel, Error>) -> Void) {
        return API.requestData(
            urlString: Endpoints.coinsURL + Endpoints.coins + params.toPath(),
            method: APICaller.HTTPMethod.GET.rawValue,
            expecting: CoinsResponseModel.self,
            completion: completion
        )
    }
    
    func getCoinDetail(
        request params: ChartRequestParams,
        completion: @escaping(Result<ChartResponseModel, Error>) -> Void) {
        return API.requestData(
            urlString: Endpoints.coinsURL + Endpoints.detailedCoin + params.toPath(),
            method: APICaller.HTTPMethod.GET.rawValue,
            expecting: ChartResponseModel.self,
            completion: completion
        )
    }
    
    func getSearchCoins(
        request params: SearchCoinRequestParams,
        completion: @escaping(Result<SearchCoinResponseModel, Error>) -> Void) {
        return API.requestData(
            urlString: Endpoints.coinsURL + Endpoints.saerch + params.toPath(),
            method: APICaller.HTTPMethod.GET.rawValue,
            expecting: SearchCoinResponseModel.self,
            completion: completion
        )
    }
}
