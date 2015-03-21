class TAPersonalViewController < UIViewController
  
  def initWithNibName(name, bundle:bundle)
    super
    self
  end

  def initWithNibName(name, bundle:bundle, id:id)
    #つぶやきコレクション
    @items = NSMutableArray.alloc.init()
    @id = id
    self
  end

  def viewDidLoad
    super
    self.view = TAPersonalView.alloc.initWithFrame(UIScreen.mainScreen.bounds, parent:self)
    load()
  end

  def load()
    BubbleWrap::HTTP.get("http://localhost:3000/api/users/#{@id}.json") do | response |
      json = BubbleWrap::JSON.parse(response.body.to_str)
      for data in json["microposts"]
        tweet = Tweet.new
        tweet.name = data["user"]["nickname"]
        tweet.content = data["content"]
        tweet.created_at = data["created_at"]
        @items.addObject(tweet)
      end
      p(json)
      follower = Follower.new
      follower.name = json["user"]["nickname"]
      follower.id = json["user"]["id"]
      if json["user"]["followed"] == nil then
        follower.isFollow = false
      else
        follower.isFollow = true
      end
      self.view.display(follower)
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

  def onClickFollow(sender)
    if sender.tag == 100
      BubbleWrap::HTTP.post("http://localhost:3000/api/relationships", payload: {relationship: {followed_id: @id}}) do | response |
        p(response)
      end
    else sender.tag == 101
      BubbleWrap::HTTP.delete("http://localhost:3000/api/relationships/#{@id}") do | response |
        p(response)
      end
    end
  end

end