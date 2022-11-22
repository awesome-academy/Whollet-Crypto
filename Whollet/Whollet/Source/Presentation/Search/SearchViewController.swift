import UIKit
import Reusable

extension SearchViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "SearchViewController", bundle: nil)
}

final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var coins = [SearchCoinModel]()
    private var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigatorBar()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = SearchViewModel()
        viewModel.bsSearchCoin.bind { [weak self] value in
            guard let self = self else { return }
            if let coins = value {
                self.coins = coins
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
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.searchCoin
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0)]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    
    private func configTableView() {
        self.tableView.register(cellType: SearchTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchTableViewCell
        let coin = coins[indexPath.row]
        cell.bindData(data: coin)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let historyItem = coins[indexPath.row]
        viewModel.saveHistory(historyItem)
        let detailPageController = DetailViewController.instantiate()
        if let id = coins[indexPath.row].id {
            detailPageController.id = id
        }
        self.navigationController?.pushViewController(detailPageController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        !searchText.isEmpty ? viewModel.getSearchCoin(searchText) : viewModel.getHistory()
    }
}
