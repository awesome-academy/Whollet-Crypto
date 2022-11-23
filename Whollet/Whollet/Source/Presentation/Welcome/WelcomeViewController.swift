import UIKit
import Reusable

final class WelcomeViewController: UIViewController {
    @IBOutlet private weak var welcomeImage: UIImageView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var wholletLabel: UILabel!
    @IBOutlet private weak var loadButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private var heightConstants: [NSLayoutConstraint]!
    @IBOutlet private var resizeLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.viewControllers.removeAll(where: { $0 != self })
        configView()
    }

    private func configView() {
        for height in heightConstants {
            height.constant *= UIScreen.resizeHeight
        }
        for label in resizeLabels {
            label.resizeWithHeight()
        }
        view.backgroundColor = UIColor.MyTheme.primary
        loadButton.fullCornerRadiusWithHeight()
        loadButton.resizeTextWithHeight()
        createButton.resizeTextWithHeight()
        welcomeLabel.resizeWithHeight()
        wholletLabel.resizeWithHeight()
    }
    
    private func toWalletPage(_ initial: WalletInitialState) {
        let walletPageController = WalletViewController.instantiate()
        walletPageController.initialState = initial
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(walletPageController, animated: true)
    }

    @IBAction func loadWalletOnClick(_ sender: UIButton) {
        toWalletPage(.load)
    }

    @IBAction func createWalletOnClick(_ sender: UIButton) {
        toWalletPage(.create)
    }
}

extension WelcomeViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "WelcomeViewController", bundle: nil)
}
