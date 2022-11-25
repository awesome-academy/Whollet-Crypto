import UIKit
import Reusable

final class AmountViewController: UIViewController {
    @IBOutlet private weak var icxView: UIView!
    @IBOutlet private weak var icxViewLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var sentICXLabel: UILabel!
    @IBOutlet private weak var sentUSDLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private var numbersButton: [UIButton]!
    private var viewModel: AmountViewModel!
    var icxPrice: Double?
    
    private var balance: Double = 0.0 {
        didSet {
            balanceLabel.text = "\(String(balance)) ICX Available"
        }
    }
    
    private var number: String = "" {
        didSet {
            sentICXLabel.text = number.isEmpty
                ? "0.00"
                : number
            sentICXLabel.textColor = number.isEmpty
                ? UIColor.MyTheme.ligthTextColor
                : UIColor.MyTheme.primary
            sentUSDLabel.text = number.isEmpty
                ? "$ 0.00"
                :  "$ " + String(String((Double(number) ?? 0) * (icxPrice ?? 0)))
            if let icx = Double(number), icx > 0, icx < balance {
                nextButton.backgroundColor = UIColor.MyTheme.primary
                nextButton.tintColor = .white
            } else {
                nextButton.backgroundColor = .none
                nextButton.tintColor = UIColor.MyTheme.primary
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configNavigatorBar()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = AmountViewModel()
        viewModel.bsBalance.bind { [weak self] value in
            if let value = value, let balance = Double(value) {
                self?.balance = balance / AppConstants.CGFloats.toBigInt
            }
        }
    }
    
    private func configView() {
        nextButton.fullCornerRadius()
        icxView.fullCornerRadius()
        nextButton.layer.borderWidth = AppConstants.CGFloats.borderWidthButton
        nextButton.layer.borderColor = UIColor.MyTheme.borderColor.cgColor
        for button in numbersButton {
            button.addTarget(self, action: #selector(numberButtonOnClick), for: .touchUpInside)
        }
    }
    
    private func configNavigatorBar() {
        navigationItem.title = AppConstants.Strings.send
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26.0 * UIScreen.resizeHeight)]
        navigationController?.navigationBar.backgroundColor = UIColor.MyTheme.primaryBackground
    }
    
    @objc func numberButtonOnClick(sender: UIButton!){
        number += String(sender.tag)
    }
    
    @IBAction func backButtonOnClick(_ sender: Any) {
        number = ""
    }
    
    @IBAction func pointButtonOnClick(_ sender: Any) {
        if !number.contains(".") && number.count > 0 {
            number += "."
        } else {
            showToast(message: AppConstants.Strings.notAddPoint, font: .systemFont(ofSize: 15 * UIScreen.resizeHeight))
        }
    }
    
    @IBAction func nextButtonOnClick(_ sender: UIButton) {
        if let icx = Double(number), icx > 0, icx < balance {
            self.viewModel.saveICXValue(icx)
            self.navigationController?.pushViewController(AddressViewController.instantiate(), animated: true)
        } else {
            showToast(message: AppConstants.Strings.notSend, font: .systemFont(ofSize: 15 * UIScreen.resizeHeight))
        }
    }
}

extension AmountViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "AmountViewController", bundle: nil)
}
