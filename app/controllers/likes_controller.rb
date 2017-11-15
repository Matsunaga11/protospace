class LikesController < ApplicationController
  def create
    @like = Like.new(
      user_id: current_user.id,
      prototype_id: params[:prototype_id]
      )
    @like.save
    redirect_to prototype_path(params[:prototype_id])
  end

  def destroy
    @like = Like.find_by(
      user_id: current_user.id,
      prototype_id: params[:prototype_id]
      )
    @like.destroy
    redirect_to prototype_path(params[:prototype_id])
  end
end
