import UIKit
import Reusable
import ICONKit

enum TransactionDetailType {
    case send
    case view
}

final class TransactionDetailViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var scrollContentView: UIView!
    @IBOutlet private var resizeLabels: [UILabel]!
    @IBOutlet private weak var backToWalletButton: UIButton!
    @IBOutlet private var heightConstraints: [NSLayoutConstraint]!
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var statusHeaderLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var totalAmountUSDLabel: UILabel!
    @IBOutlet private weak var sendFeeLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var transactionLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var type: TransactionDetailType?
    var detail: TransactionDetail?
    private var viewModel: TransactionDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let type = type {
            switch type {
            case .send:
                send()
            case .view:
                if let detail = detail {
                    loadDetailView(detail: detail)
                }
            }
        }
    }

    private func configView() {
        for height in heightConstraints {
            height.constant *= UIScreen.resizeHeight
        }
        for text in resizeLabels {
            text.resizeWithHeight()
        }
        scrollContentView.topRadius()
        backToWalletButton.resizeTextWithHeight()
        backToWalletButton.fullCornerRadius()
        configNavigatorBar()
    }

    private func send() {
        loadSendingView()
        viewModel = TransactionDetailViewModel()
        if let to = self.appDelegate?.transactionInput.address,
            let amount = self.appDelegate?.transactionInput.totalAmount,
            let wallet = self.appDelegate?.wallet {
            viewModel.sendICX(to: to, amount: amount, wallet: wallet)
        }
        
        viewModel.bsHash.bind { [weak self] value in
            guard let self = self else { return }
            if let txHash = value {
                self.navigationController?.viewControllers.removeAll(where: { $0 != self })
                if txHash.isEmpty {
                    self.loadRejectedView()
                } else {
                    self.viewModel.getTransaction(txHash: txHash)
                }
            }
        }
        viewModel.bsResult.bind { [weak self] value in
            guard let self = self else { return }
            if let result = value {
                self.loadConfirmedView(result: result)
            } else {
                self.loadRejectedView()
            }
        }
        
    }
    
    private func loadSendingView() {
        self.fromLabel.text = self.appDelegate?.wallet?.address
        self.toLabel.text = self.appDelegate?.transactionInput.address
        self.transactionLabel.text = ""
        self.totalAmountLabel.text = "\(self.appDelegate?.transactionInput.totalAmount?.description ?? "") ICX"
        self.totalAmountUSDLabel.text = "$ \(self.appDelegate?.transactionInput.totalAmountUSD?.description ?? "")"
        if let time = self.appDelegate?.transactionInput.time {
            setDateTime(time)
        }
    }
    
    private func loadDetailView(detail: TransactionDetail) {
        if let status = detail.status {
            self.statusImageView.image = UIImage(named: status)
        }
        self.statusHeaderLabel.text = detail.status == AppConstants.Strings.sent
            ? AppConstants.Strings.sent.capitalized
            : AppConstants.Strings.rejected.capitalized
        self.fromLabel.text = detail.from
        self.toLabel.text = detail.to
        self.transactionLabel.text = detail.id
        self.statusLabel.text = detail.status == AppConstants.Strings.sent
            ? AppConstants.Strings.sent.capitalized
            : AppConstants.Strings.rejected.capitalized
        self.totalAmountLabel.text = "\(detail.totalAmount?.description ?? "") ICX"
        self.totalAmountUSDLabel.text = "$ \(detail.totalAmountUSD?.description ?? "")"
        if let time = detail.time {
            setDateTime(time)
        }
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.transactionDetail
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0)]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    private func loadRejectedView() {
        viewModel.saveTransaction(detail: TransactionDetail(
            from: self.appDelegate?.wallet?.address,
            to: self.appDelegate?.transactionInput.address,
            id: "",
            status: AppConstants.Strings.rejected,
            totalAmount: self.appDelegate?.transactionInput.totalAmount,
            totalAmountUSD: self.appDelegate?.transactionInput.totalAmountUSD,
            time: self.appDelegate?.transactionInput.time))
        UIView.animate(withDuration: 0.3, animations: {
            self.statusImageView.image = UIImage(named: AppConstants.Strings.rejected)
            self.statusHeaderLabel.text = AppConstants.Strings.rejectedHeader
            self.statusLabel.text = AppConstants.Strings.rejected
        })
    }
    
    private func loadConfirmedView(result: Response.TransactionByHashResult) {
        viewModel.saveTransaction(detail: TransactionDetail(
            from: self.appDelegate?.wallet?.address,
            to: self.appDelegate?.transactionInput.address,
            id: "",
            status: AppConstants.Strings.sent,
            totalAmount: self.appDelegate?.transactionInput.totalAmount,
            totalAmountUSD: self.appDelegate?.transactionInput.totalAmountUSD,
            time: self.appDelegate?.transactionInput.time
        ))
        self.statusImageView.image = UIImage(named: AppConstants.Strings.sent)
        self.statusHeaderLabel.text = AppConstants.Strings.sent.capitalized
        self.statusHeaderLabel.textColor = UIColor.MyTheme.rejected
        self.statusLabel.text = AppConstants.Strings.sendHeader
        self.transactionLabel.text = result.blockHash
        let time = result.timestamp.hexToDate() ?? Date.now
        setDateTime(time)
    }
    
    private func setDateTime(_ date: Date) {
        self.dateLabel.text = date.getFormattedDate(format: AppConstants.Strings.dateFormatted)
        self.timeLabel.text = date.getFormattedDate(format: AppConstants.Strings.timeFormatted)
    }
    
    @IBAction func backToHomeOnClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(HomeViewController.instantiate(), animated: true)
    }
}

extension TransactionDetailViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "TransactionDetailViewController", bundle: nil)
}
