import UIKit

extension UIColor {
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0x00FF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x0000FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x000000FF) / 255.0,
            alpha: CGFloat(argb & 0xFF000000) / 255.0
        )
    }
    struct MyTheme {
        static var primary: UIColor = UIColor(argb: 0xFF347AF0)
        static var primaryBackground: UIColor = UIColor(argb: 0xFFEDF1F9)
    }
}
