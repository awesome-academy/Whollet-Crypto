import Foundation

final class GetChartlUseCase {
    private let coinsRepository: CoinsRepository
    
    init(coinsRepository: CoinsRepository) {
        self.coinsRepository = coinsRepository
    }
    
    func getDetailChart(params: ChartRequestParams, completion: @escaping (ChartResponseModel?, Error?) -> Void) {
        return coinsRepository.getCoinDetail(params: params, completion: completion)
    }
}
