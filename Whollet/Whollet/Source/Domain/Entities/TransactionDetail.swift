import Foundation
import CoreData

struct TransactionDetail: Equatable, Codable {
    let from: String?
    let to: String?
    let id: String?
    let status: String?
    let totalAmount: Double?
    let totalAmountUSD: Double?
    let time: Date?
    
    init(from: String?, to: String?, id: String?, status: String?, totalAmount: Double?, totalAmountUSD: Double?, time: Date?) {
        self.from = from
        self.to = to
        self.id = id
        self.status = status
        self.totalAmount = totalAmount
        self.totalAmountUSD = totalAmountUSD
        self.time = time
    }
    
    init() {
        self.from = ""
        self.to = ""
        self.id = ""
        self.status = ""
        self.totalAmount = 0.0
        self.totalAmountUSD = 0.0
        self.time = nil
    }

    init(item: NSManagedObject) {
        self.from = item.value(forKey: "from") as? String
        self.to = item.value(forKey: "to") as? String
        self.id = item.value(forKey: "id") as? String
        self.status = item.value(forKey: "status") as? String
        self.totalAmount = item.value(forKey: "total_amount") as? Double
        self.totalAmountUSD = item.value(forKey: "total_amount_usd") as? Double
        self.time = item.value(forKey: "time") as? Date
    }
}
