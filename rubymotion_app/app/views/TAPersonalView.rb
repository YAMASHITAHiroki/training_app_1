class TAPersonalView < UIScrollView
  def initWithFrame(frame, parent:parent)
    initWithFrame(frame)
    self.backgroundColor = UIColor.whiteColor
    @detailArea = UIView.alloc.initWithFrame(CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 100))

    @name = UILabel.alloc.initWithFrame(CGRectZero)

    @addBtn = UIButton.buttonWithType(UIButtonTypeContactAdd)
    @addBtn.frame = CGRectMake(frame.size.width - @addBtn.frame.size.width - 30, 10, @addBtn.frame.size.width, @addBtn.frame.size.height)
    @addBtn.tag = 100
    @addBtn.addTarget(parent, action:"onClickFollow:", forControlEvents:UIControlEventTouchUpInside)
    @addBtn.hidden = true

    @deleteBtn = UIButton.buttonWithType(UIButtonTypeInfoLight)
    @deleteBtn.tag = 101
    @deleteBtn.frame = CGRectMake(@addBtn.frame.origin.x, @addBtn.frame.origin.y, @deleteBtn.frame.size.width, @deleteBtn.frame.size.height)
    @deleteBtn.addTarget(parent, action:"onClickFollow:", forControlEvents:UIControlEventTouchUpInside)
    @deleteBtn.hidden = true

    @tweetTable = UITableView.alloc.initWithFrame(CGRectMake(@detailArea.frame.origin.x, @detailArea.frame.origin.y + @detailArea.frame.size.height, frame.size.width, frame.size.height))
    @tweetTable.delegate = parent
    @tweetTable.dataSource = parent

    @detailArea.addSubview(@name)
    @detailArea.addSubview(@addBtn)
    @detailArea.addSubview(@deleteBtn)
    self.addSubview(@detailArea)
    self.addSubview(@tweetTable)
    self.contentSize = CGSizeMake(frame.size.width, @detailArea.frame.size.height+@tweetTable.frame.size.height)
    self
  end

  def display(follower)
    @name.text = follower.name
    @name.sizeToFit
    @name.frame = CGRectMake(10, 10, @name.frame.size.width, @name.frame.size.height)
    @tweetTable.reloadData()
    if follower.isFollow then
      @addBtn.hidden = true
      @deleteBtn.hidden = false
    else
      @deleteBtn.hidden = true
      @addBtn.hidden = false
    end
  end

end