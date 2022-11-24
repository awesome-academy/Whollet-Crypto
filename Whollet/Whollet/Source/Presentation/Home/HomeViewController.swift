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
        self.navigationController?.viewControllers.removeAll(where: { $0 != self })
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
                    self.tableView.tableFooterView = SpinnerFooter.loadFromNib()
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
                        size: AppConstants.Ints.priceStringSize)
                }
                
            }
        }
    }
    
    private func configView() {
        safeAreaView.backgroundColor = UIColor.MyTheme.primary
        icxPriceView.backgroundColor = UIColor.MyTheme.primary
        icxPriceText.resizeWithHeight()
        
        tabBarBottomView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius
        tabBarBottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        topCoinView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius
        topCoinView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        depositButton.fullCornerRadius()
        depositButton.layer.borderWidth = AppConstants.CGFloats.depositButtonBorder
        depositButton.layer.borderColor = UIColor.MyTheme.primaryBackground.cgColor
    }
    
    private func configTableView() {
        tableView.register(cellType: CoinTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.icx
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(
                ofSize: AppConstants.CGFloats.appBarTitleSize * UIScreen.resizeHeight)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primary
    }
    
    @IBAction private func seeAllTopCoinsOnTap(_ sender: UIButton) {
        let coinsPageController = CoinsViewController.instantiate()
        self.navigationController?.pushViewController(coinsPageController, animated: true)
    }
    
    @IBAction private func searchButtonOnClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(SearchViewController.instantiate(), animated: true)
    }
    
    @IBAction private func depositButtonOnClick(_ sender: UIButton) {
        let depositPageController = DepositViewController.instantiate()
        if let sheet = depositPageController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = AppConstants.CGFloats.defaultRadius
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        self.present(depositPageController, animated: true, completion: nil)
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
        let detailPageController = DetailViewController.instantiate()
        if let id = coins[indexPath.row].id {
            detailPageController.id = id
        }
        self.navigationController?.pushViewController(detailPageController, animated: true)
    }
}
