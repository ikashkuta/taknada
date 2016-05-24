import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	// TODO: We need more precise getComponent() method (name, guid, more semantics in order to understand
	// appropriate layout node) in order to make this factory methods more clean.
	// Remove tuples
	func setupScene1(window: Entity) {
		let e1 = EntityFactory.makeSimple()
		let e2 = EntityFactory.makeSimple()
		let e3 = EntityFactory.makeDraggable()
		let b1 = EntityFactory.makeScrollable()

		let windowLayout: Layout = window.getComponent()
		b1.baseLayout.parent = windowLayout

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

	func setupScene2(window: Entity) {
		let e1 = EntityFactory.makeDraggable()
		let e2 = EntityFactory.makeDraggable()
		let e3 = EntityFactory.makeDraggable()

		let windowLayout: Layout = window.getComponent()
		e1.layout.parent = windowLayout
		e2.layout.parent = windowLayout
		e3.layout.parent = windowLayout
	}

	func setupScene3(window: Entity) {
		let t1 = EntityFactory.makeText()

		t1.textData.text = "Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world! Hello world!"

		let windowLayout: Layout = window.getComponent()
		t1.layout.parent = windowLayout
	}

	func setupScene4(window: Entity) {
		let t1 = EntityFactory.makeText()
		let t2 = EntityFactory.makeText()
		let t3 = EntityFactory.makeText()
		let t4 = EntityFactory.makeText()
		let t5 = EntityFactory.makeText()
		let t6 = EntityFactory.makeText()
		let t7 = EntityFactory.makeText()
		let t8 = EntityFactory.makeText()
		let b1 = EntityFactory.makeScrollable()

		let windowLayout: Layout = window.getComponent()
		b1.baseLayout.parent = windowLayout

		t1.textData.text = "Hello"
		t1.textData.font = UIFont.systemFontOfSize(30)
		t2.textData.text = "My name is"
		t3.textData.text = "Always IGOR!!!!!!!!!"
		t3.textData.textColor = UIColor.blueColor()
		t4.textData.text = "And yours? Yours! Yours! Yours! Yours! Yours! Yours! Yours! Yours!"
		t4.textData.font = UIFont.systemFontOfSize(10)
		t5.textData.text = "What is you name? Say again? I didn't hear you."
		t6.textData.text = "VADOS?"
		t7.textData.textColor = UIColor.purpleColor()
		t7.textData.text = "What is it?"
		t8.textData.text = "Some kind of OS?"

		t1.layout.parent = b1.scrollLayout
		t2.layout.parent = b1.scrollLayout
		t3.layout.parent = b1.scrollLayout
		t4.layout.parent = b1.scrollLayout
		t5.layout.parent = b1.scrollLayout
		t6.layout.parent = b1.scrollLayout
		t7.layout.parent = b1.scrollLayout
		t8.layout.parent = b1.scrollLayout

		t1.render.parent = b1.render
		t2.render.parent = b1.render
		t3.render.parent = b1.render
		t4.render.parent = b1.render
		t5.render.parent = b1.render
		t6.render.parent = b1.render
		t7.render.parent = b1.render
		t8.render.parent = b1.render
	}

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
		let rootViewController = UIViewController.init()
		rootViewController.view.backgroundColor = UIColor.whiteColor()
		self.window?.rootViewController = rootViewController
		self.window?.makeKeyAndVisible()

		let windowEntity = EntityFactory.makeWindow(rootViewController.view)
		self.entities.append(windowEntity)

		let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, 0);
		let renderQueue = dispatch_queue_create("org.taknada.render", attr);
		dispatch_set_target_queue(renderQueue, dispatch_get_main_queue())

		let layoutQueue = dispatch_queue_create("org.taknada.layout", DISPATCH_QUEUE_SERIAL)
		let scriptsQueue = dispatch_queue_create("org.taknada.scripts", DISPATCH_QUEUE_SERIAL)

		SystemLocator.renderSystem = RenderSystem(window: windowEntity.getComponent(), queue: renderQueue)
		SystemLocator.layoutSystem = LayoutSystem(window: windowEntity.getComponent(), queue: layoutQueue)
		SystemLocator.scriptSystem = ScriptSystem(queue: scriptsQueue)

//		self.setupScene1(windowEntity)
//		self.setupScene2(windowEntity)
//		self.setupScene3(windowEntity)
		self.setupScene4(windowEntity)

		// Currently needed for scene 2 :(
//		SystemLocator.layoutSystem?.setNeedsUpdate()

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
