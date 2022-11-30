import Foundation

final class SearchViewModel: NSObject {
    private var getSearchCoinUseCase: GetSearchCoinUseCase!
    private var getSearchHistoryUseCase: GetSearchHistoryUseCase!
    private var saveSearchHistoryUseCase: SaveSearchHistoryUseCase!
    private(set) var bsSearchCoin: BehaviorSubject<[SearchCoinModel]> = BehaviorSubject(nil)
    
    override init() {
        super.init()
        self.getSearchCoinUseCase = GetSearchCoinUseCase(coinsRepository: CoinsRepositoryImpl())
        self.getSearchHistoryUseCase = GetSearchHistoryUseCase(repository: SearchHistoryRepositoryImpl())
        self.saveSearchHistoryUseCase = SaveSearchHistoryUseCase(repository: SearchHistoryRepositoryImpl())
        getHistory()
    }
    
    func getSearchCoin(_ keyword: String) {
        let params = SearchCoinRequestParams(query: keyword)
        self.getSearchCoinUseCase.getSearchCoin(params: params) { [weak self] (data, error) -> Void in
            guard let self = self, error == nil, let data = data else { return }
            self.bsSearchCoin.add(data.coins ?? [])
        }
    }
    
    func getHistory() {
        getSearchHistoryUseCase.get { [weak self] (data, error) -> (Void) in
            guard let self = self, error == nil else { return }
            self.bsSearchCoin.add(data)
        }
    }
    
    func saveHistory(_ search: SearchCoinModel) {
        saveSearchHistoryUseCase.save(search) 
    }
}
