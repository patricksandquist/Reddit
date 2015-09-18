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
    if @user.save
      render json: @user
    else
      flash.now[:errors] = ["Username/password combination not found"]
      render :new
    end
  end

  def destroy
  end
end
