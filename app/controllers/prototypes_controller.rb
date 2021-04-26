class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  
  #  before_action move_to_index, expect: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    if Prototype.create
      redirect_to prototypes_path
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if current_user.user!
      redirect_to root_path
    end
  end

  def show
    
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments   = @prototype.comment.includes(:user)
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
     prototype.destroy
      redirect_to prototypes_path
  end

  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end