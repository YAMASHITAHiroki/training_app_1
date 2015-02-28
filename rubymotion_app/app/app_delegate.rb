class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = TATweetViewController.alloc.initWithNibName(nil, bundle: nil)
    rootViewController.title = 'Top'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)
    
    mainController = TAMainTabBarController.alloc.init
    mainController.viewControllers = [navigationController]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = mainController
    @window.makeKeyAndVisible

    true
  end
end
