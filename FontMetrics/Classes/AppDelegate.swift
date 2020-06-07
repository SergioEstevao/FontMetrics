import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FontManager.ensureCustomFontsAreLoaded()
        let contentView = FontListView()
        self.window!.rootViewController = UIHostingController(rootView: contentView)
        self.window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return loadFont(url: url)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return loadFont(url: url)
    }

    func loadFont(url: URL) -> Bool {
        if let result = try? FontManager.shared.addFont(fromURL: url) {
            return !result.isEmpty
        } else {
            return false
        }
    }

}
