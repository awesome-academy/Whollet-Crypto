import Foundation

final class GetSearchCoinUseCase {
    private let coinsRepository: CoinsRepository
    
    init(coinsRepository: CoinsRepository) {
        self.coinsRepository = coinsRepository
    }
    
    func getSearchCoin(params: SearchCoinRequestParams, completion: @escaping (SearchCoinResponseModel?, Error?) -> Void) {
        coinsRepository.getSearchCoin(params: params, completion: completion)
    }
}
