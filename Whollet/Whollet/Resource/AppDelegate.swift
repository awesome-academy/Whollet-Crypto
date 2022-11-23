import UIKit
import ICONKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var wallet: Wallet?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(
            name: "OnboardingScreen",
            bundle: nil
        ).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
