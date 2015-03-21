class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    tweetViewController = TATweetViewController.alloc.initWithNibName(nil, bundle: nil)
    tweetViewController.title = 'ホーム'
    tweetViewController.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemTopRated, tag:0)
    tweetNavigationController = UINavigationController.alloc.initWithRootViewController(tweetViewController)

    noticeViewController = TATweetViewController.alloc.initWithNibName(nil, bundle:nil)
    noticeViewController.title = "通知"
    noticeViewController.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemContacts, tag:1)
    noticeNavigationController = UINavigationController.alloc.initWithRootViewController(noticeViewController)

    messageViewController = TATweetViewController.alloc.initWithNibName(nil, bundle:nil)
    messageViewController.title = "メッセージ"
    messageViewController.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemDownloads, tag:2)
    messageNavigationController = UINavigationController.alloc.initWithRootViewController(messageViewController)

    accountViewController = TATweetViewController.alloc.initWithNibName(nil, bundle:nil)
    accountViewController.title = "アカウント"
    accountViewController.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFeatured, tag:3)
    accountNavigationController = UINavigationController.alloc.initWithRootViewController(accountViewController)

    mainController = UITabBarController.alloc.init()
    mainController.viewControllers = [tweetNavigationController, 
            noticeNavigationController, 
            messageNavigationController, 
            accountNavigationController]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = mainController
    @window.makeKeyAndVisible

    true
  end
end
