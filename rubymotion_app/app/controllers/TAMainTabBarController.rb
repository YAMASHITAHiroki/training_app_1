class TAMainTabBarController < UITabBarController
  def viewDidLoad
    btn = UIButton.buttonWithType(UIButtonTypeContactAdd)
    btn.frame = CGRectMake((self.view.frame.size.width - btn.size.width)/2, (self.view.frame.size.height - btn.size.height)/2, btn.size.width, btn.size.height)
    btn.addTarget(self,
		  action: "get:",
		  forControlEvents: UIControlEventTouchDown)
    self.view.addSubview(btn)
  end

  def get(sender)
    p "onClick"
    BW::HTTP.get("https://api.twitter.com/1.1/search/tweets.json") do |response|
      p response.body.to_str
      
    end
  end
end
