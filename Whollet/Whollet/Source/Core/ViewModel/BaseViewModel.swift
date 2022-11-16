import Foundation

class BaseViewModel: NSObject {
    var bind: (() -> Void) = { }
}

