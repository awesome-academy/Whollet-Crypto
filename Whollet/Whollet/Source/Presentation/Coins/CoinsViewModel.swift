import Foundation

final class CoinsViewModel: NSObject {
    private var getCoinsUseCase: GetCoinsUseCase!
    private var page = 1
    private(set) var bsCoins: BehaviorSubject<[CoinModel]> = BehaviorSubject(nil)

    override init() {
        super.init()
        self.getCoinsUseCase = GetCoinsUseCase()
        getCoins()
    }

    func getCoins() {
        let params = CoinsRequestParams(
            order: "market_cap_desc",
            perPage: AppConstants.Ints.countLoad,
            page: page,
            sparkline: false,
            ids: nil)
        
        self.getCoinsUseCase.getCoins(params: params) { [weak self] (data, error) -> Void in
            guard let self = self, error == nil, let data = data else { return }
            self.bsCoins.add((self.bsCoins.value ?? []) + data)
        }
    }
    
    func loadMore() {
        page += 1
        getCoins()
    }
    
    func reload() {
        page = 1
        self.bsCoins.add([])
        getCoins()

    }
}
