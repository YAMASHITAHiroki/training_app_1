class TAFollowerTableViewCell < UITableViewCell

  def initWithStyle(style, reuseItentifire: id)
    super
    self
  end

  def initWithTweet(follower)
    init()
    @name = UILabel.alloc.initWithFrame(CGRectZero)
    @name.text = follower.name
    @name.font = UIFont.fontWithName(Define::FONT_ARIAL_BOLD, size:Define::CELL_NAME_FONT_SIZE)
    @name.sizeToFit()
    @name.frame = CGRectMake(Define::MARGIN_LEFT, Define::MARGIN_TOP, @name.frame.size.width, @name.frame.size.height)

    self.contentView.addSubview(@name)

    self
  end
end