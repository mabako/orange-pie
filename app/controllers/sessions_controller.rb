class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Hi there'
    else
      flash.now.alert = 'Could not log you in'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Smell you later'
  end
end
