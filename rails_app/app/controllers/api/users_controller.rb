class Api::UsersController < Api::BaseController
  def index
    @users = User.all
  end
end
