class CommentsController < ApplicationController
  def create
    @comment = Comment.create(text: params[:text], prototype_id: params[:prototype_id], user_id: current_user.id)
    redirect_to "/prototypes/#{@comment.prototype.id}"
  end

  private
  def comment_params
    params.permit(:text, :prototype_id)
  end
end
