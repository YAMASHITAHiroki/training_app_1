class Api::MicropostsController < ApplicationController
  before_action :set_micropost, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)

    respond_to do |format|
      if @micropost.save
        format.json { render :show, status: :created, location: @micropost }
      else
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_micropost
      @micropost = current_user.microposts.find(params[:id])
    end

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
