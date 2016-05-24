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

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
		let rootViewController = UIViewController.init()
		rootViewController.view.backgroundColor = UIColor.whiteColor()
		self.window?.rootViewController = rootViewController
		self.window?.makeKeyAndVisible()

		let windowEntity = WindowManager.make(rootViewController.view)

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

//		self.setupScene4(windowEntity)
		let scene4 = Scene4Script.make(windowEntity)

		// Currently needed for scene 2 :(
//		SystemLocator.layoutSystem?.setNeedsUpdate()

		return true
	}
}
