class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @comment = Comment.create(text: params[:text], prototype_id: params[:prototype_id], user_id: current_user.id)
      respond_to do |format|
        format.html { redirect_to "/prototypes/#{@comment.prototype.id}" }
        format.json
      end
    end
  end

  def destroy
      @comment = Comment.find(params[:id])
    if user_signed_in? && current_user.id == @comment.user.id
      @comment.destroy
      redirect_to "/prototypes/#{@comment.prototype.id}"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    if user_signed_in? && current_user.id == @comment.user.id
      @prototype = Prototype.find(params[:prototype_id])
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if user_signed_in? && current_user.id == @comment.user.id
      @comment.update(comment_params)
      redirect_to "/prototypes/#{@comment.prototype.id}"
    end
  end

  private
  def comment_params
    params.permit(:text, :prototype_id)
  end
end
