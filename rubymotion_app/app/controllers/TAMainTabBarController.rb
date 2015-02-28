class TAMainTabBarController < UITabBarController
  def init()
    p "initialize"
    self
  end

  def viewDidLoad
    super
    p "ViewDidLoad"
    @name = ""
    @email = ""
    textWidth = 200
    nameText = UITextField.alloc.initWithFrame(CGRectMake((self.view.frame.size.width - textWidth)/2, 100, textWidth, 25))
    nameText.borderStyle = UITextBorderStyleRoundedRect
    nameText.tag = 101
    nameText.delegate = self
    
    emailText = UITextField.alloc.initWithFrame(CGRectMake(nameText.frame.origin.x, nameText.frame.size.height+nameText.frame.origin.y+5, nameText.frame.size.width, nameText.frame.size.height))
    emailText.borderStyle = UITextBorderStyleRoundedRect
    emailText.tag = 102
    emailText.delegate = self

    btn = UIButton.buttonWithType(UIButtonTypeInfoDark)
    btn.frame = CGRectMake((self.view.frame.size.width - btn.size.width)/2, (self.view.frame.size.height - btn.size.height)/2, btn.size.width, btn.size.height)
    btn.addTarget(self,
		  action: "get:",
		  forControlEvents: UIControlEventTouchDown)
    self.view.addSubview(btn)
    self.view.addSubview(nameText)
    self.view.addSubview(emailText)
    self.view.addSubview(@nameLabel)
  end

  def get(sender)
    BW::HTTP.post("http://localhost:3000/users", payload: {user:{name:@name, email:@email}}) do |response|
      p response
    end
  end

  #TextFiledDelegate
  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
    return true
  end

  def textFieldDidEndEditing(textField)
    case textField.tag
    when 101 then
      @name = textField.text
    when 102 then
      @email = textField.text
    end
    p textField.text
  end
end
