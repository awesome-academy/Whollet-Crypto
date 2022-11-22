import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet private weak var splashImage: UIImageView!
    @IBOutlet private weak var indexPage: UIPageControl!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var titleText: UILabel!
    @IBOutlet private weak var descriptionText: UILabel!
    @IBOutlet private weak var nextStepButton: UIButton!
    
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        bottomView.layer.cornerRadius = AppConstants.CGFloats.defaultRadius
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nextStepButton.fullCornerRadius()
        nextStepButton.layer.borderWidth = AppConstants.CGFloats.borderWidthButton
        nextStepButton.layer.borderColor = UIColor.MyTheme.primary.cgColor
        titleText.resizeWithHeight()
        descriptionText.resizeWithHeight()
        navigationController?.isNavigationBarHidden = true
        configNextPage()
    }
    
    private func configNextPage() {
        let pageData = AppConstants.onboardings[index]
        splashImage.image = UIImage(named: pageData.image)
        indexPage.currentPage = index
        titleText.text = pageData.title
        descriptionText.text = pageData.description

        let isLastPage = index == AppConstants.onboardings.count - 1
        nextStepButton.setTitle(
            isLastPage
            ? AppConstants.Strings.getStarted
            : AppConstants.Strings.nextStep,
            for: .normal)
        nextStepButton.setTitleColor(isLastPage ? .white : UIColor.MyTheme.primary, for: .normal)
        nextStepButton.backgroundColor = isLastPage ? UIColor.MyTheme.primary : .white
    }
    
    private func toHomePage() {
        let homePageController = HomeViewController.instantiate()
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(homePageController, animated: true)
    }
    
    @IBAction private func onTapSkip(_ sender: UIButton) {
        toHomePage()
    }
    
    @IBAction private func onTapNextStep(_ sender: Any) {
        if index == AppConstants.onboardings.count - 1 {
            toHomePage()
        } else {
            index = (index + 1) % AppConstants.onboardings.count
            configNextPage()
        }
    }
    
    @IBAction private func onTapPageIndex(_ sender: UIPageControl) {
        index = sender.currentPage
        configNextPage()
    }
}
