class Api::TopController < Api::BaseController
  def index
    @microposts = current_user.microposts
  end
end
