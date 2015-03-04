class TARegistView < UIView
  TEXT_FIELD_WIDTH = 200
  TEXT_FIELD_HEIGHT = 25
  MARGIN_LEFT = 10
  MARGIN_TOP = 25
  @@NAME_FIELD_TAG = 101
  @@MAIL_FIELD_TAG = 102

  def initWithFrame(rect)
    super
    self.backgroundColor = UIColor.whiteColor

    @name = getLabel("名前")
    @name.frame = CGRectMake((self.frame.size.width - @name.frame.size.width - TEXT_FIELD_WIDTH)/2, 100, @name.frame.size.width, @name.frame.size.height)

    @nameLabel = getTextField()
    @nameLabel.tag = @@NAME_FIELD_TAG
    @nameLabel.frame = CGRectMake(@name.frame.origin.x + @name.frame.size.width + MARGIN_LEFT, @name.frame.origin.y - ((TEXT_FIELD_HEIGHT-@name.frame.size.height)/2), TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)

    @mail = getLabel("Mail")
    @mail.frame = CGRectMake(@name.frame.origin.x, @name.frame.origin.y + @name.frame.size.height + MARGIN_TOP, @mail.frame.size.width, @mail.frame.size.height)
    
    @mailLabel = getTextField()
    @mailLabel.tag = @@MAIL_FIELD_TAG
    @mailLabel.frame = CGRectMake(@mail.frame.origin.x + @mail.frame.size.width + MARGIN_LEFT, @mail.frame.origin.y - ((TEXT_FIELD_HEIGHT - @mail.frame.size.height)/2), TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)
    
    self.addSubview(@name)
    self.addSubview(@nameLabel)
    self.addSubview(@mail)
    self.addSubview(@mailLabel)
    self
  end  

  def getLabel(title)
    label = UILabel.alloc.init()
    label.text = title
    label.sizeToFit()
    return label
  end

  def getTextField()
    field = UITextField.alloc.init()
    field.borderStyle = UITextBorderStyleRoundedRect
    return field
  end
  
  def setDelegate(parent)
    @nameLabel.delegate = parent
    @mailLabel.delegate = parent
  end
end
