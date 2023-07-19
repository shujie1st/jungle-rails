class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate_with_credentials(params[:email], params[:password])
    if @user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
      flash[:alert] = 'Login failed!'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end

end
