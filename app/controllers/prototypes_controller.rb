class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :new]
  before_action :move_to_index, only: [:edit, :update, :destroy]

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
    prototype = Prototype.find(params[:id])
  if prototype.user_id != current_user.id
    redirect_to action: :index
  end
  end
end