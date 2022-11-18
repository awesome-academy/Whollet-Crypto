import UIKit
import Reusable

final class HomeViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "HomeViewController", bundle: nil)
    @IBOutlet private weak var tabBarBottomView: UIView!
    @IBOutlet private weak var safeAreaView: UIView!
    @IBOutlet private weak var icxPriceView: UIView!
    @IBOutlet private weak var topCoinView: UIView!
    @IBOutlet private weak var icxPriceText: UILabel!
    @IBOutlet private weak var depositButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var coins: [CoinModel] = []
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigatorBar()
    }
    
    private func bindViewModel() {
        bindCoins()
        bindICXCoins()
    }
        
    private func bindCoins() {
        viewModel.bsDataCoins.bind { [weak self] value in
            guard let self = self else { return }
            if let coins = value {
                self.coins = coins ?? []
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = self.createSpinnerFooter()
                }
            }
        }
    }
    
    private func bindICXCoins() {
        viewModel.bsICXCoins.bind { [weak self] value in
            guard let self = self else { return }
            if let icxCoin = value {
                let price = icxCoin?.currentPrice?.description ?? ""
                DispatchQueue.main.async {
                    self.icxPriceText.text = "$ " + String(
                        text: price,
                        size: AppConstants.Ints.priceStringSize.rawValue)
                }
                
            }
        }
    }
    
    private func configView() {
        safeAreaView.backgroundColor = UIColor.MyTheme.primary
        icxPriceView.backgroundColor = UIColor.MyTheme.primary
        icxPriceText.resizeWithHeight()
        
        tabBarBottomView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius.rawValue
        tabBarBottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        topCoinView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius.rawValue
        topCoinView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        depositButton.fullCornerRadius()
        depositButton.layer.borderWidth = AppConstants.CGFloats.depositButtonBorder.rawValue
        depositButton.layer.borderColor = UIColor.MyTheme.primaryBackground.cgColor
    }
    
    private func configTableView() {
        tableView.register(cellType: CoinTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.icx.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(
                ofSize: AppConstants.CGFloats.appBarTitleSize.rawValue * UIScreen.resizeHeight)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primary
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    @IBAction func seeAllTopCoinsOnTap(_ sender: UIButton) {
        // TODO implement go Top Coin
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CoinTableViewCell
        let coin = coins[indexPath.row]
        cell.bindData(data: coin)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO implement go Detail Coin
    }
}