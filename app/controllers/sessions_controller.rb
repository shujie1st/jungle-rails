class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # if user exists and password is correct
    if user && user.authenticate(params[:password])
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
