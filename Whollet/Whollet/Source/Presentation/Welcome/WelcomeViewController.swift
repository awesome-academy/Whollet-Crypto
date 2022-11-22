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

    @IBAction func loadWalletOnClick(_ sender: UIButton) {
        // TODO implement go Load Wallet
    }

    @IBAction func createWalletOnClick(_ sender: UIButton) {
        // TODO implement go Create Wallet
    }
}

extension WelcomeViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "WelcomeViewController", bundle: nil)
}
