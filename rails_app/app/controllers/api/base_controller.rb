class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  # respond_to :json
  # before_action :authenticate_user!

  def current_user
    User.find_by(nickname: "taro")
  end
end
