import UIKit
import Reusable

final class CoinsViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "CoinsViewController", bundle: nil)
    @IBOutlet private weak var safeAndTopView: UIView!
    @IBOutlet private weak var tableContainerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private var viewModel: CoinsViewModel!
    private var coins = [CoinModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        bindViewModel()
     }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configNavigatorBar()
    }
    
    private func bindViewModel() {
        viewModel = CoinsViewModel()

        viewModel.bsCoins.bind { [weak self] value in
            guard let self = self else { return }
            if let coins = value {
                self.coins = coins
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = SpinnerFooter.loadFromNib()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.allTopCoins
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0 * UIScreen.resizeHeight)]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    private func configView() {
        safeAndTopView.backgroundColor = UIColor.MyTheme.primaryBackground
        tableContainerView.layer.cornerRadius = 20
        tableContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func configTableView() {
        self.tableView.register(cellType: CoinTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func loadMore() {
        self.tableView.tableFooterView = SpinnerFooter.loadFromNib()
        self.viewModel.loadMore()
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        self.viewModel.reload()
        DispatchQueue.main.async {
            self.tableView.tableHeaderView = nil
        }
    }
}

extension CoinsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CoinTableViewCell
        let coin = coins[indexPath.row]
        cell.bindData(data: coin)
        if indexPath.row == self.coins.count - 1 {
            self.loadMore()
        }
        return cell
    }
}

extension CoinsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPageController = DetailViewController.instantiate()
        if let id = coins[indexPath.row].id {
            detailPageController.id = id
        }
        self.navigationController?.pushViewController(detailPageController, animated: true)
    }
}
