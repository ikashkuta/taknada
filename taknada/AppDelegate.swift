import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController = UIViewController.init()
        rootViewController.view.backgroundColor = UIColor.orange
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        return true
    }

    var env: Environment!

    func makeTestScene() {
        let uikitSystem = UIKitSystem(window: self.window!, queue: DispatchQueue.main)
        self.env = Environment(systems: [uikitSystem])
    }

    func makeText() {

    }

    func makeButton() {

    }

    func makeAlertView() {
        self.makeText()
        self.makeButton()
        self.makeButton()
        //let c = EntityConfig(name: "AlertView", components: )
    }
}
