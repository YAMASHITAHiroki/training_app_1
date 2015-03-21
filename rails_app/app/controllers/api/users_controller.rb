class Api::UsersController < Api::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
end
