import UIKit
import Reusable

final class SearchTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var idAndNameText: UILabel!
    @IBOutlet private weak var searchBarView: UIView!
    @IBOutlet private weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        searchBarView.layer.cornerRadius = AppConstants.CGFloats.cellRadius
        searchBarView.backgroundColor = UIColor.MyTheme.primaryBackground
        selectionStyle = .none
    }
    
    func bindData(data: SearchCoinModel) {
        if let logoURL = data.large, let url = URL(string: logoURL) {
            logoImageView.loadFrom(from: url)
        }
        idAndNameText.text = "\(data.id ?? "") - \(data.name ?? "")"
        if let rank = data.marketCapRank {
            rankLabel.text = "Rank \(rank)"
        }
        
    }
}
