#ツイート投稿画面コントローラー
class TATweetPostViewController < UIViewController
  
  def initWithNibName(nibName, bundle:bundle)
    super
    @postText = ""
    self
  end

  def viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemStop, target:self, action:"onClickCloseButton:")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemReply, target:self, action:"onClickPostButton:")
    self.view = TATweetPostView.alloc.initWithFrame(UIScreen.mainScreen.bounds, parent: self, user: "Sample")

  end

  def onClickCloseButton(target)
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  def onClickPostButton(target)
    if @postText != "" then
      BubbleWrap::HTTP.post("http://localhost:3000/api/microposts", payload: {micropost: {content: @postText}}) do | response |
        p(response.body)
        self.dismissViewControllerAnimated(true, completion:nil)
      end
    end
  end

  #UITextViewDelegateMethod
  def textViewDidBeginEditing(textView)
    if textView.text == "いまどうしてる？" then
      textView.text = ""
      textView.textColor = UIColor.blackColor
    end
    textView.becomeFirstResponder()
  end

  def textViewDidEndEditingquit(textView)
    if textView.text == "" then
      textView.text = "いまどうしてる？"
      textView.textColor = UIColor.lightGrayColor
      textView.resignFirstResponder()
    end
  end

  def textView(textView, shouldChangeTextInRange:range, replacementText:text)
    @postText = textView.text+text
    true
  end
end