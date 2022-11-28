import UIKit

final class TransactionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var transactionItemView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var amountUSDLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var resizeLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        statusImageView.clipsToBounds = true
        transactionItemView.layer.cornerRadius = AppConstants.CGFloats.cellRadius * UIScreen.resizeHeight
        for text in resizeLabels {
            text.resizeWithHeight()
        }
        transactionItemView.backgroundColor = UIColor.MyTheme.primaryBackground
        selectionStyle = .none
    }
    
    func bindData(data: TransactionDetail) {
        if let status = data.status {
            let isSent = status == AppConstants.Strings.sent
            statusLabel.text = isSent
                ? AppConstants.Strings.sent.capitalized
                : AppConstants.Strings.rejected.capitalized
            statusImageView.image = UIImage(named: isSent
                                            ? AppConstants.Strings.sent
                                            : AppConstants.Strings.rejected)
        }
        amountLabel.text = "\(String(text: (data.totalAmount ?? 0).description, size: 8)) ICX"
        amountUSDLabel.text = "$ \(data.totalAmountUSD?.description ?? "")"
        if let time = data.time {
            self.dateLabel.text = time.getFormattedDate(format: AppConstants.Strings.dateFormatted)
        }
    }
}
