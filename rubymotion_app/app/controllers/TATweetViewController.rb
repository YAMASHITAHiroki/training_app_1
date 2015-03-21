#Tweet一覧表示ViewController
class TATweetViewController < UITableViewController
  
  def initWithNibName(name, bundle: bundle)
    super
    #ツイートアイテムコレクション
    @items = NSMutableArray.alloc.init()
    #ツイートロードフラグ
    @loadFlg = true
    #ナビゲーションボタン設定
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:"onClickUserSearch:")
    postItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCompose, target:self, action:"onClickPost:")
    self.navigationItem.rightBarButtonItems = NSArray.arrayWithObjects(postItem, nil)
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
      getTweet()
    end
  end

  #ptivateMethod
  def getTweet()
    BubbleWrap::HTTP.get("http://localhost:3000/api/index.json") do | response |
      @items.removeAllObjects()
      json = BubbleWrap::JSON.parse(response.body.to_str)
      for data in json do
        tweet = Tweet.new
        tweet.name = data["user"]["nickname"]
        tweet.content = data["content"]
        tweet.created_at = data["created_at"]
        @items.addObject(tweet)
      end
      self.tableView.reloadData()
      @loadFlg = false
      self.refreshControl.endRefreshing()
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
    cell = TATweetTableViewCell.alloc.initWithTweet(@items.objectAtIndex(path.row))
    cell
  end

  #UITableViewDelegateMethod
  #セルの高さを動的に変更する
  def tableView(table, heightForRowAtIndexPath:indexPath)
    contentText = @items.objectAtIndex(indexPath.row).content
    maxSize = CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)

    fontAttrs = NSDictionary.dictionaryWithObject(UIFont.systemFontOfSize(Define::CELL_CONTENT_FONT_SIZE), forKey:NSFontAttributeName)
    fontSize = contentText.boundingRectWithSize(
      maxSize, 
      options:NSStringDrawingUsesLineFragmentOrigin, 
      attributes:fontAttrs, 
      context:nil
    ).size
    nameText = @items.objectAtIndex(indexPath.row).name
    nameFontAttrs = NSDictionary.dictionaryWithObject(UIFont.systemFontOfSize(Define::CELL_NAME_FONT_SIZE), forKey:NSFontAttributeName)
    nameFontSize = nameText.boundingRectWithSize(
      maxSize, 
      options:NSStringDrawingUsesLineFragmentOrigin, 
      attributes:nameFontAttrs, 
      context:nil
    ).size
    [fontSize.height + nameFontSize.height + 10, 40].max
  end

  #OnClickMethod
  def onClickUserSearch(sender)
    searchViewController = TASearchViewController.alloc.init()
    self.navigationController.pushViewController(searchViewController, animated:true)
  end

  def onClickPost(sender)
    @loadFlg = true;
    postViewController = TATweetPostViewController.alloc.init()
    postNavCon = UINavigationController.alloc.initWithRootViewController(postViewController)
    self.presentViewController(postNavCon, animated:true, completion: nil)
  end

  #refreshMethod
  def onRefresh(sender)
    self.refreshControl.beginRefreshing()
    getTweet()
  end

end
