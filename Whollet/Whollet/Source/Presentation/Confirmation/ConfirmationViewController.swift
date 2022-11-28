import UIKit
import Reusable

final class ConfirmationViewController: UIViewController {
    
    @IBOutlet private var resizeLabels: [UILabel]!
    @IBOutlet private var heightConstraints: [NSLayoutConstraint]!
    @IBOutlet private weak var confimButton: UIButton!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var amountUSDLabel: UILabel!
    @IBOutlet private weak var feeLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var totalAmountUSDLabel: UILabel!
    private var viewModel: ConfirmationViewModel!
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private var totalAmount = 0.0
    private var totalAmountUSD = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = ConfirmationViewModel()
        viewModel.bsICXCoins.bind { [weak self] value in
            guard let self = self else { return }
            
            if let icxPrice = value?.currentPrice {
                DispatchQueue.main.async {
                    self.addressLabel.text = self.appDelegate?.transactionInput.address
                    let amount = self.appDelegate?.transactionInput.valueICX ?? 0
                    self.amountLabel.text = "\(amount.description) ICX"
                    let amountUSD = amount * icxPrice
                    self.amountUSDLabel.text = "$ \(amountUSD.description)"
                    let totalAmount = amount + AppConstants.CGFloats.transactionFee
                    self.totalAmount = totalAmount
                    self.totalAmountLabel.text = "\(totalAmount.description) ICX"
                    let totalAmountUSD = totalAmount * icxPrice
                    self.totalAmountUSD = totalAmountUSD
                    self.totalAmountUSDLabel.text = "$ \(totalAmountUSD.description)"
                }
            }
        }
    }
    
    private func configView() {
        for txt in resizeLabels {
            txt.resizeWithHeight()
        }
        for height in heightConstraints {
            height.constant *= UIScreen.resizeHeight
        }
        confimButton.fullCornerRadius()
        confimButton.resizeTextWithHeight()
        configNavigatorBar()
        bottomView.topRadius()
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.send
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0)]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    
    @IBAction private func confirmOnClick(_ sender: UIButton) {
        appDelegate?.transactionInput.time = Date.now
        appDelegate?.transactionInput.totalAmount = self.totalAmount
        appDelegate?.transactionInput.totalAmountUSD = self.totalAmountUSD
        let page = TransactionDetailViewController.instantiate()
        page.type = .send
        self.navigationController?.pushViewController(page, animated: true)
    }
}

extension ConfirmationViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "ConfirmationViewController", bundle: nil)
}
