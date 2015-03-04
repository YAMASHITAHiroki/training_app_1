class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    tweetViewController = TATweetViewController.alloc.initWithNibName(nil, bundle: nil)
    tweetViewController.title = 'Top'
    tweetViewController.view.backgroundColor = UIColor.whiteColor

    tweetNavigationController = UINavigationController.alloc.initWithRootViewController(tweetViewController)

    registViewController = TARegistViewController.alloc.initWithNibName(nil, bundle:nil)
    registViewController.title = "Nextz"
    registNavigationController = UINavigationController.alloc.initWithRootViewController(registViewController)

    mainController = UITabBarController.alloc.init
    mainController.viewControllers = [registNavigationController, tweetNavigationController]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = mainController
    @window.makeKeyAndVisible

    true
  end
end
