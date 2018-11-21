class SubsController < ApplicationController
  
  before_action :require_loggin!
  before_action :ensure_moderator, only: [:edit, :update]
  
  def index
    @subs = Sub.all
  end
  
  def new
    @sub = Sub.new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def ensure_moderator
    redirect_to sub_url(params[:id]) unless Sub.find(params[:id]).user_id == current_user.id
  end
  
end
