import Foundation

struct SearchCoinRequestParams: BaseRequestParams {
    let query: String
    
    func toPath() -> String {
        return "/?query=\(query)"
    }
}
