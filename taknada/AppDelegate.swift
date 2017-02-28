import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?
    ) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController = UIViewController.init()
        rootViewController.view.backgroundColor = UIColor.orange
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        makeTestScene()
        return true
    }

    var env: Environment!

    func makeTestScene() {
        let uikitSystem = UIKitSystem(window: window!)
        env = Environment(systems: [uikitSystem])
        makeSimple()
        uikitSystem.needUpdate()
    }

    func makeSimple() {
        let c1 = EntityConfig(taggedComponents: [(component: UIKitComponent(), tags: [])], name: "basic")
        let e1 = env.make(config: c1)
        e1.write(key: ConventionKeys.UIKitComponent.backgroundColor, data: UIColor.white, persistent: false)
        e1.write(key: ConventionKeys.UIKitComponent.frame, data: CGRect(x: 100, y: 100, width: 100, height: 100), persistent: false)
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
