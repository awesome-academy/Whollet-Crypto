import UIKit
import Reusable

final class DepositViewController: UIViewController {
    @IBOutlet private weak var depositCoinsLabel: UILabel!
    @IBOutlet private weak var depositView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var icxView: UIView!
    @IBOutlet private weak var QRView: UIView!
    @IBOutlet private weak var QRImageView: UIImageView!
    @IBOutlet private weak var walletAddressView: UIView!
    @IBOutlet private weak var walletAddressLabel: UILabel!
    @IBOutlet private var heightConstraints: [NSLayoutConstraint]!
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        for height in heightConstraints {
            height.constant *= UIScreen.resizeHeight
        }
        depositCoinsLabel.resizeWithHeight()
        walletAddressLabel.resizeWithHeight()
        view.backgroundColor = UIColor(argb: 0x11000000)
        depositView.topRadius()
        backButton.fullCornerRadiusWithHeight()
        backButton.layer.borderWidth = AppConstants.CGFloats.depositButtonBorder
        backButton.layer.borderColor = UIColor.MyTheme.primaryBackground.cgColor
        icxView.fullCornerRadiusWithHeight()
        QRView.layer.cornerRadius = AppConstants.CGFloats.cellRadius
        if let address = appDelegate?.wallet?.address {
            walletAddressLabel.text = address
            QRImageView.generateQRCode(from: address)
        }
    }
    
    @IBAction private func copyOnClick(_ sender: UIButton) {
        UIPasteboard.general.string = appDelegate?.wallet?.address
        showToast(message: AppConstants.Strings.copied, font: .systemFont(ofSize: 15 * UIScreen.resizeHeight))
    }
    
    @IBAction private func shareOnClick(_ sender: UIButton) {
        UIApplication.share(appDelegate?.wallet?.address ?? "")
    }
}

extension DepositViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "DepositViewController", bundle: nil)
}
