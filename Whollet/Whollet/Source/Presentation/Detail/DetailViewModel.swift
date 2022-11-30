import Foundation
import Charts

enum TimeChart {
    case day
    case week
    case month
    case year
}

final class DetailViewModel: NSObject {
    private var getCoinsUseCase: GetCoinsUseCase!
    private var getChartUseCase: GetChartlUseCase!
    
    private(set) var bsCoin: BehaviorSubject<CoinModel> = BehaviorSubject(nil)
    private(set) var bsChart: BehaviorSubject<[ChartDataEntry]> = BehaviorSubject(nil)
    
    override init() {
        super.init()
        self.getCoinsUseCase = GetCoinsUseCase(coinsRepository: CoinsRepositoryImpl())
        self.getChartUseCase = GetChartlUseCase(coinsRepository: CoinsRepositoryImpl())
    }
    
    func getDetail(id: String) {
        let param = CoinsRequestParams(
            order: "market_cap_desc",
            perPage: 1,
            page: 1,
            sparkline: false,
            ids: id)
        
        self.getCoinsUseCase.getCoins(params: param) { [weak self] (data, error) -> Void in
            guard let self = self, error == nil,  let data = data, data.count == 1 else { return }
            self.bsCoin.add(data.last)
        }
    }
    
    func getChart(timeType: TimeChart, id: String) {
        var days = 1
        var interval: String?
        switch timeType {
        case .week:
            days = 7
        case .month:
            days = 30
            interval = "daily"
        case .year:
            days = 365
            interval = "weekly"
        default:
            break
        }
        let param = ChartRequestParams(
            id: id,
            day: days,
            interval: interval)
        
        self.getChartUseCase.getDetailChart(params: param) { [weak self] (data, error) -> Void in
            guard let self = self, error == nil, let data = data else { return }
            var dataChart = [ChartDataEntry]()
            dataChart = data.prices.enumerated().map { index, value -> ChartDataEntry in
                return ChartDataEntry(x: Double(index), y: value[1])
            }
            self.bsChart.add(dataChart)
        }
    }
}
