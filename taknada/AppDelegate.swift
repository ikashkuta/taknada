import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
		let rootViewController = UIViewController.init()
		rootViewController.view.backgroundColor = UIColor.whiteColor()
		self.window?.rootViewController = rootViewController
		self.window?.makeKeyAndVisible()

		let windowEntity = Entity.Window.make(rootViewController.view)

		let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 0);
		let renderQueue = dispatch_queue_create("org.taknada.render", attr);
		dispatch_set_target_queue(renderQueue, dispatch_get_main_queue())

		let layoutQueue = dispatch_queue_create("org.taknada.layout", DISPATCH_QUEUE_SERIAL)
		let scriptsQueue = dispatch_queue_create("org.taknada.scripts", DISPATCH_QUEUE_SERIAL)

		SystemLocator.renderSystem = RenderSystem(window: windowEntity.getComponent(), queue: renderQueue)
		SystemLocator.layoutSystem = LayoutSystem(window: windowEntity.getComponent(), queue: layoutQueue)
		SystemLocator.scriptSystem = ScriptSystem(queue: scriptsQueue)

//		let scene1 = Scene1.make(windowEntity)
//		let scene2 = Scene2.make(windowEntity)
//		let scene3 = Scene3.make(windowEntity)
		let scene4 = Scene4.make(windowEntity)

		SystemLocator.layoutSystem?.setNeedsUpdate() // TODO: Currently needed for scene 2 :(

		return true
	}
}
