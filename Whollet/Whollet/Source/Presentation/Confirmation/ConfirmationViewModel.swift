import Foundation
import UIKit
import ICONKit

final class ConfirmationViewModel: NSObject {

    private var getCoinsUseCase: GetCoinsUseCase!
    
    private(set) var bsICXCoins: BehaviorSubject<CoinModel> = BehaviorSubject(nil)
    
    override init() {
        super.init()
        self.getCoinsUseCase = GetCoinsUseCase(coinsRepository: CoinsRepositoryImpl())
        self.getICXPrice()
    }
    
    private func getICXPrice() {
        let params = CoinsRequestParams(
            order: "market_cap_desc",
            perPage: 1,
            page: 1,
            sparkline: false,
            ids: "icon")
        
        self.getCoinsUseCase.getCoins(params: params) { [weak self] (data, error) -> Void in
            guard let self = self, error == nil, let data = data, data.count == 1 else { return }
            self.bsICXCoins.add(data.last)
        }
    }
}
