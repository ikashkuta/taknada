import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController = UIViewController.init()
        rootViewController.view.backgroundColor = UIColor.orange
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

    var env: Environment!

    func makeTestScene() {
        let uikitSystem = UIKitSystem(window: window!, queue: DispatchQueue.main)
        env = Environment(systems: [uikitSystem])
    }

    func makeText() {

    }

    func makeButton() {

    }

    func makeAlertView() {
        makeText()
        makeButton()
        makeButton()
        //let c = EntityConfig(name: "AlertView", components: )
    }
}
