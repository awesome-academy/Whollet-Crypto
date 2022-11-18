import Foundation

struct CoinsRequestParams: BaseRequestParams {
    let vsCurrency: String
    let order: String
    let perPage: Int
    let page: Int
    let sparkline: Bool
    let ids: String?
    
    init(vsCurrency: String = "usd", order: String, perPage: Int, page: Int, sparkline: Bool, ids: String?) {
        self.vsCurrency = vsCurrency
        self.order = order
        self.perPage = perPage
        self.page = page
        self.sparkline = sparkline
        self.ids = ids
    }
    
    func toPath() -> String {
        var path = "?vs_currency=\(vsCurrency)&order=\(order)&per_page=\(perPage)&page=\(page)&sparkline=\(sparkline)"
        if let ids = ids {
            path = "\(path)&ids=\(ids)"
        }
        return path
    }
}
