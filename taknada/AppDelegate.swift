import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var entities = [Entity]()

	// TODO: We need more precise getComponent() method (name, guid, more semantics in order to understand
	// appropriate layout node) in order to make this factory methods more clean.
	func setupScene1() {
		let e1 = EntityFactory.makeSimple()
		let e2 = EntityFactory.makeSimple()
		let e3 = EntityFactory.makeDraggable()
		let b1 = EntityFactory.makeScrollable()
		self.entities.appendContentsOf([e1.entity, e2.entity, e3.entity, b1.entity])

		e1.layout.data.localTransform = CGAffineTransformMakeTranslation(10, 0)
		e2.layout.data.localTransform = CGAffineTransformMakeTranslation(130, 0)
		e3.layout.data.localTransform = CGAffineTransformMakeTranslation(250, 0)

		e1.layout.parent = b1.scrollLayout
		e2.layout.parent = b1.scrollLayout
		e3.layout.parent = b1.scrollLayout

		e1.render.parent = b1.render
		e2.render.parent = b1.render
		e3.render.parent = b1.render
	}

	func setupScene2() {
		let e1 = EntityFactory.makeDraggable()
		let e2 = EntityFactory.makeDraggable()
		let e3 = EntityFactory.makeDraggable()
		self.entities += [e1.entity, e2.entity, e3.entity]
	}

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
		let rootViewController = UIViewController.init()
		rootViewController.view.backgroundColor = UIColor.whiteColor()
		self.window?.rootViewController = rootViewController
		self.window?.makeKeyAndVisible()

		let w = EntityFactory.makeWindow(rootViewController.view)
		self.entities.append(w.entity)

		let renderQueue = dispatch_get_main_queue()
		let layoutQueue = dispatch_queue_create("layout", DISPATCH_QUEUE_SERIAL) // TODO: QoS
		let scriptsQueue = dispatch_queue_create("scripts", DISPATCH_QUEUE_SERIAL)

		SystemLocator.renderSystem = RenderSystem(window: w.render, queue: renderQueue)
		SystemLocator.layoutSystem = LayoutSystem(window: w.layout, queue: layoutQueue)
		SystemLocator.dispatchSystem = DispatchSystem(queue: scriptsQueue)

		self.setupScene1()
//		self.setupScene2()

		SystemLocator.layoutSystem?.setNeedsUpdate()
		SystemLocator.renderSystem?.setNeedsUpdate()
//		SystemLocator.dispatchSystem?.setNeedsUpdate() // don't need to

		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}
