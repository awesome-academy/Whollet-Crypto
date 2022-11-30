import Foundation

struct CoinModel: Codable, Equatable {
    let id, symbol, name: String?
    let image: String?
    let marketCapRank: Int?
    let currentPrice: Double?
    let priceChange24H: Double?
    let atlDate: String?
    
    init() {
        self.id = ""
        self.symbol = ""
        self.image = ""
        self.name = ""
        self.currentPrice = 0.0
        self.priceChange24H = 0.0
        self.marketCapRank = 0
        self.atlDate = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case marketCapRank = "market_cap_rank"
        case currentPrice = "current_price"
        case priceChange24H = "price_change_24h"
        case atlDate = "atl_date"
    }
}

typealias CoinsResponseModel = [CoinModel]
