import UIKit
import Charts
import Reusable

extension DetailViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
}

final class DetailViewController: UIViewController {
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNaneAndIdLabel: UILabel!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var coinRankLabel: UILabel!
    @IBOutlet private weak var coinPriceChange24hLabel: UILabel!
    @IBOutlet private weak var chartContainerView: UIView!
    @IBOutlet private var chartTimeTypeButtons: [UIButton]!
    @IBOutlet weak var coinChartView: LineChartView!
    private var viewModel = DetailViewModel()
    var id: String?
    private var timeChart: TimeChart = .day

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configView()
    }
    
    private func bindViewModel() {
        if let id = id {
            viewModel.getDetail(id: id)
            viewModel.getChart(timeType: timeChart, id: id)
        }
        
        viewModel.bsCoin.bind { [weak self] value in
            if let self = self, let detail = value {
                DispatchQueue.main.async {
                    self.loadCoinDetail(data: detail)
                }
            }
        }
        
        viewModel.bsChart.bind { [weak self] value in
            if let self = self, let chartEntry = value {
                let set = LineChartDataSet(entries: chartEntry, label: "Line chart")
                set.drawCirclesEnabled = false
                set.mode = .linear
                set.lineWidth = 1
                set.setColor(chartEntry.first?.y ?? 0 < chartEntry.last?.y ?? 0 ? .green : .red)
                let data = LineChartData(dataSet: set)
                data.setDrawValues(false)
                DispatchQueue.main.async {
                    self.coinChartView.data = data
                    self.coinChartView.animate(xAxisDuration: 2)
                }
            }
        }
    }
    
    private func loadCoinDetail(data: CoinModel) {
        if let imageURL = data.image, let url = URL(string: imageURL) {
            coinImageView.loadFrom(from: url)
        }
        coinNaneAndIdLabel.text = "\(data.name ?? "") - \(data.id ?? "")"
        coinPriceLabel.text = "$\(data.currentPrice?.description ?? "")"
        coinRankLabel.text = data.marketCapRank?.description
        if let priceChange = data.priceChange24H {
            coinPriceChange24hLabel.text = String(text: priceChange.description, size: 8)
            coinPriceChange24hLabel.textColor = priceChange > 0
                ? UIColor.MyTheme.priceUp
                : UIColor.MyTheme.priceDown
        }
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.detailCoin
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(
                ofSize: 26.0 * UIScreen.resizeHeight)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    private func configView() {
        reloadButton()
        configNavigatorBar()
        chartContainerView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius
        chartContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        configureChart()
    }
    
    private func configureChart() {
        coinChartView.rightAxis.enabled = false
        coinChartView.xAxis.labelPosition = .bottom
        coinChartView.xAxis.axisLineColor = .white
        coinChartView.xAxis.setLabelCount(6, force: false)
        coinChartView.animate(xAxisDuration: 2)
    }
    
    private func reloadButton() {
        var indexButton = 0
        switch timeChart {
        case .week:
            indexButton = 1
        case .month:
            indexButton = 2
        case .year:
            indexButton = 3
        default:
            break
        }
        
        for index in 0..<chartTimeTypeButtons.count {
            chartTimeTypeButtons[index].backgroundColor = .none
        }
        chartTimeTypeButtons[indexButton].backgroundColor = UIColor.white.withAlphaComponent(0.1)
        if let id = id {
            viewModel.getChart(timeType: timeChart, id: id)
        }
    }
    
    @IBAction func dayClick(_ sender: UIButton) {
        timeChart = .day
        DispatchQueue.main.async { [weak self] in
            self?.reloadButton()
        }
    }
    
    @IBAction func weekClick(_ sender: UIButton) {
        timeChart = .week
        DispatchQueue.main.async { [weak self] in
            self?.reloadButton()
        }
    }
    
    @IBAction func monthClick(_ sender: UIButton) {
        timeChart = .month
        DispatchQueue.main.async { [weak self] in
            self?.reloadButton()
        }
    }
    
    @IBAction func yearClick(_ sender: UIButton) {
        timeChart = .year
        DispatchQueue.main.async { [weak self] in
            self?.reloadButton()
        }
    }
}

