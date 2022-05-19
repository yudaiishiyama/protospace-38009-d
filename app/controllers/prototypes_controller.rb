class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit,:destroy, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype=Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path(@prototype)
    else
      render :new
    end
  end

  def show
    @prototype =Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update_attributes(prototype_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end 

  private
  def prototype_params
    params.require(:prototype).permit(:title, :image, :catch_copy,:concept).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in? == current_user.name
      redirect_to root_path
    end
  end
end