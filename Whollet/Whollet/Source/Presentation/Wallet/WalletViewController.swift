import UIKit
import Reusable

enum WalletInitialState {
    case load
    case create
}

final class WalletViewController: UIViewController {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    var initialState: WalletInitialState?
    private var viewModel: WalletViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel = WalletViewModel()
        viewModel.bsWalletState.bind { [weak self] value in
            guard let self = self else { return }
            if let state = value {
                switch state {
                case .inProgress:
                     DispatchQueue.main.async {
                        self.descriptionLabel.text = self.initialState == .create
                            ? AppConstants.Strings.createICX
                            : AppConstants.Strings.loadWallet
                        self.nextButton.setTitle(AppConstants.Strings.loading, for: .normal)
                        self.nextButton.backgroundColor = UIColor.MyTheme.primary.withAlphaComponent(0.5)
                    }
                case .loadSuccess:
                    let isCreate = self.initialState == .create
                    DispatchQueue.main.async {
                        self.descriptionLabel.text = isCreate
                            ? AppConstants.Strings.createWalletSuccessfully
                            : AppConstants.Strings.loadWalletSuccessfully
                        self.showToast(
                            message: isCreate
                              ? AppConstants.Strings.createWalletSuccessfully
                              : AppConstants.Strings.loadWalletSuccessfully,
                            font: .systemFont(ofSize: 15 * UIScreen.resizeHeight))
                        self.nextButton.setTitle(AppConstants.Strings.goHome, for: .normal)
                        self.nextButton.backgroundColor = UIColor.MyTheme.primary
                    }
                default:
                    break
                }
            }
        }
    }
    
    private func configView() {
        nextButton.resizeTextWithHeight()
        nextButton.fullCornerRadius()
        guard let initialState = initialState else {
            return
        }
        let isCreate = initialState == .create
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.navigationItem.title = isCreate 
                    ? AppConstants.Strings.createWallet 
                    : AppConstants.Strings.loadWallet
                self.descriptionLabel.text = isCreate
                    ? AppConstants.Strings.createICX
                    : AppConstants.Strings.copyPrimaryKey
                self.nextButton.setTitle(isCreate ? AppConstants.Strings.createWallet : AppConstants.Strings.pasteKey, for: .normal)
                self.nextButton.backgroundColor = UIColor.MyTheme.primary
            }
        }
    }
    
    @IBAction func nextButtonOnClick(_ sender: UIButton) {
        guard let initialState = initialState else {
            return
        }
        switch viewModel.bsWalletState.value {
        case .initial:
            initialState == .create ? viewModel.createWallet() : viewModel.loadWallet(UIPasteboard.general.string ?? "")
        case .loadSuccess:
            let homePageController = HomeViewController.instantiate()
            self.navigationController?.pushViewController(homePageController, animated: true)
        default:
            return
        }
    }
}

extension WalletViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "WalletViewController", bundle: nil)
}
