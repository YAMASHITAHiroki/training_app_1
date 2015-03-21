class TASearchViewController < UITableViewController
  def initWithNibName(name, bundle: bundle)
    super
    #フォロワーコレクション
    @items = NSMutableArray.alloc.init()
    #フォロワーロードフラグ
    @loadFlg = true
    self
  end

  def viewDidLoad()
    super
    self.view.delegate = self
    self.view.dataSource = self

    refreshControl = UIRefreshControl.alloc.init()
    refreshControl.addTarget(self, action:"onRefresh:", forControlEvents:UIControlEventValueChanged)
    self.refreshControl = refreshControl
  end

  def viewWillAppear(animated)
    super
    if @loadFlg then
      @items.removeAllObjects()
      getFollower()
    end
  end

    #ptivateMethod
  def getFollower()
    BubbleWrap::HTTP.get("http://localhost:3000/api/users.json") do | response |
      json = BubbleWrap::JSON.parse(response.body.to_str)
      for data in json
        p(data)
        follower = Follower.new
        follower.name = data["nickname"]
        follower.id = data["id"]
        @items.addObject(follower)
      end
      self.tableView.reloadData()
      @loadFlg = false
    end
  end

  #UITableViewDelegateMethod
  #セルの個数
  def tableView(table, numberOfRowsInSection:section)
    return @items.count
  end

  #UITableViewDelegateMethod
  #セル設定
  def tableView(table, cellForRowAtIndexPath:path)
    cell = TAFollowerTableViewCell.alloc.initWithTweet(@items.objectAtIndex(path.row))
    cell
  end

  def tableView(table, didSelectRowAtIndexPath:path)
    selectedFollower = @items.objectAtIndex(path.row)
    personalViewController = TAPersonalViewController.alloc.initWithNibName(nil, bundle:nil, id:selectedFollower.id)
    self.navigationController.pushViewController(personalViewController, animated:true)
  end

  #UITableViewDelegateMethod
  #セルの高さを動的に変更する
  def tableView(table, heightForRowAtIndexPath:indexPath)
    contentText = @items.objectAtIndex(indexPath.row).name
    maxSize = CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)
    fontAttrs = NSDictionary.dictionaryWithObject(UIFont.systemFontOfSize(Define::CELL_CONTENT_FONT_SIZE), forKey:NSFontAttributeName)
    fontSize = contentText.boundingRectWithSize(
      maxSize, 
      options:NSStringDrawingUsesLineFragmentOrigin, 
      attributes:fontAttrs, 
      context:nil
    ).size
    [fontSize.height + 10, 40].max
  end
end