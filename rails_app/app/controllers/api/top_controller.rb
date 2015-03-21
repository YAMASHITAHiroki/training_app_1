class Api::TopController < Api::BaseController
  def index
    @microposts = current_user.feed
  end
end
