class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.all.page(params[:page]).per(8)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'New prototype was unsuccessfully created'
     end
  end

  def show
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.user_id == current_user.id
      @prototype.destroy
    end
  end

  def edit

  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path , notice: 'prototype was successfully updated'
    else
      flash.now[:alert] = 'prototype was unsuccessfully updated'
      render :edit
     end
  end

  def index_popular
   prototype_ids = Like.group(:prototype_id).order('count_prototype_id DESC').count(:prototype_id).keys
   @prototypes = Prototype.where(id: prototype_ids).order("FIELD(id, #{prototype_ids.join(',')})").page(params[:page]).per(8)
   render "prototypes/index"
 end

 def index_newest
   @prototypes = Prototype.all.order('created_at DESC').page(params[:page]).per(8)
   render "prototypes/index"
 end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status],
      tag_ids: []
    )
  end
end
