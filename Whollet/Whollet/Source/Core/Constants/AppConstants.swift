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
        static let createWallet = "Create Wallet"
        static let createICX = "Create a ICX Wallet"
        static let loadWallet = "Load Wallet"
        static let copyPrimaryKey = "Copy privateKey to Clipboard and Paste"
        static let pasteKey = "Paste Key"
        static let loading = "Loading"
        static let loadingWallet = "Loading a ICX Wallet"
        static let createWalletSuccessfully = "Your wallet has been created successfully, private key save on clipboard"
        static let goHome = "Go Home"
        static let loadWalletSuccessfully = "Your wallet has been loaded successfully"
        static let send = "Send"
        static let transactionDetail = "Transaction Detail"
        static let copied = "Copied"
        static let sendNonce = "0x1"
        static let notSend = "Not send"
        static let notAddPoint = "Not add point"
        static let failedGetCamera = "Failed to get the camera device"
        static let iconShow = "show"
        static let iconHide = "hide"
    }
    
    enum CGFloats {
        static let defaultRadius = 20.0
        static let borderWidthButton = 1.0
        static let appBarTitleSize = 26.0
        static let depositButtonBorder = 3.0
        static let cellRadius = 10.0
        static let toastHeight = 35.0
        static let toashWidth = 300.0
        static let toashLeading = 37.5
        static let toastBottom = 200.0
        static let toastWidth = 0.8
        static let toastAlpha = 1.0
        static let toastDuration = 4.0
        static let toastDelay = 4.0
        static let toBigInt = 1000000000000000000.0
    }
    
    enum Ints {
        static let priceStringSize = 8
        static let countLoad = 20
        static let sendStepLimit = 1000000
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
