class Api::RelationshipsController < Api::BaseController
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow!(user)
    respond_to do |format|
      format.js
    end
  end
end
