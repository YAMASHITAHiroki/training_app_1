class TATweetTableViewCell < UITableViewCell

  def initWithStyle(style, reuseItentifire: id)
    super
    self
  end

  def initWithTweet(tweet)
    init()
    @name = UILabel.alloc.initWithFrame(CGRectZero)
    @name.text = tweet.name
    @name.font = UIFont.fontWithName(Define::FONT_ARIAL_BOLD, size:Define::CELL_NAME_FONT_SIZE)
    @name.sizeToFit()
    @name.frame = CGRectMake(Define::MARGIN_LEFT, Define::MARGIN_TOP, @name.frame.size.width, @name.frame.size.height)

    @date = UILabel.alloc.initWithFrame(CGRectZero)
    @date.text = tweet.created_at
    @date.font = UIFont.systemFontOfSize(Define::CELL_DATE_FONT_SIZE)
    @date.sizeToFit()
    @date.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-@date.frame.size.width-Define::MARGIN_LEFT, @name.frame.origin.y, @date.frame.size.width, @date.frame.size.height)

    @content = UILabel.alloc.initWithFrame(CGRectZero)
    @content.text = tweet.content
    @content.font = UIFont.systemFontOfSize(Define::CELL_CONTENT_FONT_SIZE)
    @content.sizeToFit()
    @content.lineBreakMode = NSLineBreakByWordWrapping
    @content.numberOfLines = 0
    @content.frame = CGRectMake(@name.frame.origin.x, @name.frame.size.height + @name.frame.origin.y + Define::MARGIN_TOP, UIScreen.mainScreen.bounds.size.width-Define::MARGIN_LEFT*2, @content.frame.size.height)
    @content.sizeToFit()

    self.contentView.addSubview(@name)
    self.contentView.addSubview(@content)
    self.contentView.addSubview(@date)

    self
  end
end