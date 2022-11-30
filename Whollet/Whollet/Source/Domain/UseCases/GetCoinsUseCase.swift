import Foundation

final class GetCoinsUseCase {
    private let coinsRepository: CoinsRepository
    
    init(coinsRepository: CoinsRepository) {
        self.coinsRepository = coinsRepository
    }
    
    func getCoins(params: CoinsRequestParams, completion: @escaping (CoinsResponseModel?, Error?) -> Void) {
        return coinsRepository.getCoins(params: params, completion: completion)
    }
}
