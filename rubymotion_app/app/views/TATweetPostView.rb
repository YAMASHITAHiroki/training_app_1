#ツイート投稿画面
class TATweetPostView < UIView
  def initWithFrame(rect)
    super
    self.backgroundColor = UIColor.whiteColor
    self
  end

  def initWithFrame(rect, parent: parent, user: user)
    initWithFrame(rect)
    @user = user
    @textView = UITextView.alloc.initWithFrame(rect)
    @textView.becomeFirstResponder()
    @textView.text = "いまどうしてる？"
    @textView.textColor = UIColor.lightGrayColor
    @textView.delegate = parent
    self.addSubview(@textView)
    self
  end
end