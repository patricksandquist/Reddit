class SubsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      @sub = Sub.new
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to user_sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages

      render :update
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy

    redirect_to :user_subs
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end

  private

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
