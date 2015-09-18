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
      @user = Sub.new
      render :new
    end
  end

  def update
  end

  def destroy
  end

  def show
  end

  def index
  end

  private

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
