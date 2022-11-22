import Foundation

struct AppConstants {
    enum Strings {
        static let nextStep = "Next Step"
        static let getStarted = "Let's Get Started"
        static let iconPriceUp = "price_up"
        static let iconPriceDown = "price_down"
        static let icx = "ICX"
        static let allTopCoins = "All Top Coins"
        static let detailCoin = "Detail Coin"
        static let searchCoin = "Search Coin"
    }
    
    enum CGFloats {
        static let defaultRadius = 20.0
        static let borderWidthButton = 1.0
        static let appBarTitleSize = 26.0
        static let depositButtonBorder = 3.0
        static let cellRadius = 10.0
    }
    
    enum Ints {
        static let priceStringSize = 8
        static let countLoad = 20
    }
    
    static let onboardings: [OnboardingModel] = [
        OnboardingModel(
            image: "splash_0",
            title: "Welcome to Whollet",
            description: "Manage all your crypto assets! It’s simple and easy! "
        ),
        OnboardingModel(
            image: "splash_1",
            title: "Nice and Tidy Crypto Portfolio!",
            description: "Keep ICX based tokens."
        ),
        OnboardingModel(
            image: "splash_2",
            title: "Receive and Send Money to Friends!",
            description: "Send crypto to your friends. "
        ),
        OnboardingModel(
            image: "splash_3",
            title: "Your Safety is Our Top Priority",
            description: "Our top-notch security features will keep you completely safe."
        )
    ]
}
