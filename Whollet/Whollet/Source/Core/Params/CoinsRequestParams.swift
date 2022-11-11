import Foundation

struct CoinsRequestParams: BaseRequestParams {
    let vsCurrency: String
    let order: String
    let perPage: Int
    let page: Int
    let sparkline: Bool
    
    public func toPath() -> String {
        return "?vs_currency=\(vsCurrency)&order=\(order)&per_page=\(perPage)&page=\(page)&sparkline=\(sparkline)"
    }
}
