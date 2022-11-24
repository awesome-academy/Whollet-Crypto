import UIKit

extension UIViewController {
    func showToast(message: String, font: UIFont) {
        let toastLabel = ToastLabel(message: message, font: font)
        self.view.addSubview(toastLabel)
        UIView.animate(
            withDuration: AppConstants.CGFloats.toastDuration,
            delay: AppConstants.CGFloats.toastDelay,
            options: .curveEaseOut,
            animations: {
                toastLabel.alpha = 0.0
            },
            completion: { _ in
                toastLabel.removeFromSuperview()
            }
        )
    }
    
    private func ToastLabel(message: String, font: UIFont) -> UILabel {
        let toastLabel = UILabel(
            frame: CGRect(
                x: AppConstants.CGFloats.toashLeading * UIScreen.resizeWidth,
                y: self.view.frame.size.height - AppConstants.CGFloats.toastBottom,
                width: AppConstants.CGFloats.toashWidth * UIScreen.resizeWidth,
                height: AppConstants.CGFloats.toastHeight * UIScreen.resizeHeight))
        toastLabel.backgroundColor = UIColor.MyTheme.toastBackground
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = AppConstants.CGFloats.toastAlpha
        toastLabel.layer.cornerRadius = AppConstants.CGFloats.cellRadius
        toastLabel.clipsToBounds = true
        return toastLabel
    }
}
