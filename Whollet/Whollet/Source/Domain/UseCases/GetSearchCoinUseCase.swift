import Foundation

final class GetSearchCoinUseCase {
    private let coinRepository = CoinsRepositoryImpl()
    
    func getSearchCoin(params: SearchCoinRequestParams, completion: @escaping (SearchCoinResponseModel?, Error?) -> Void) {
        coinRepository.getSearchCoin(params: params, completion: completion)
    }
}
