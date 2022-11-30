import Foundation
import CoreData

struct SearchCoinModel: Codable {
    let id, symbol, apiSymbol, name: String?
    let large: String?
    let marketCapRank: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, large
        case apiSymbol = "api_symbol"
        case marketCapRank = "market_cap_rank"
    }
    
    init(item: NSManagedObject) {
        self.id = item.value(forKey: "id") as? String
        self.symbol = item.value(forKey: "symbol") as? String
        self.apiSymbol = item.value(forKey: "api_symbol") as? String
        self.name = item.value(forKey: "name") as? String
        self.large = item.value(forKey: "large") as? String
        self.marketCapRank = item.value(forKey: "market_cap_rank") as? Int
    }
    
    init() {
        self.id = ""
        self.symbol = ""
        self.apiSymbol = ""
        self.name = ""
        self.large = ""
        self.marketCapRank = 0
    }
}

extension SearchCoinModel: Equatable {
    static func == (lhs: SearchCoinModel, rhs: SearchCoinModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct SearchCoinResponseModel: Codable, Equatable {
    let coins: [SearchCoinModel]?
}
