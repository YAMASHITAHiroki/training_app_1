class TARegistViewController < UIViewController
  def viewDidLoad()
    self.view = TARegistView.alloc.initWithFrame(self.view.frame)
    self.view.setDelegate(self)
  end
  
  def textFieldShouldReturn(textField)
    textField.resignFirstResponder()
    return false
  end
end
