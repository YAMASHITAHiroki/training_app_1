class TopController < ApplicationController
  def index
    if current_user
      @microposts = current_user.microposts
    end
  end
end
