class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      log_in_user(@user)
      redirect_to new_user_sub_url(@user)
    else
      flash.now[:errors] = ["Username/password combination not found"]
      @user = User.new
      render :new
    end
  end

  def destroy
    @user = User.new
    log_out_user

    render :new
  end
end
