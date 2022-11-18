import Foundation

struct ChartRequestParams: BaseRequestParams {
    let id: String
    let vsCurrency: String
    let day: Int
    let interval: String?
    
    init(vsCurrency: String = "usd", id: String, day: Int, interval: String?) {
        self.id = id
        self.vsCurrency = vsCurrency
        self.day = day
        self.interval = interval
    }
    
    func toPath() -> String {
        var path = "/\(id)/market_chart?vs_currency=\(vsCurrency)&days=\(day)"
        if let interval = interval {
            path = "\(path)&interval=\(interval)"
        }
        return path
    }
}
