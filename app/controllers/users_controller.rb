class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user], :as => :create)
    if @user.save
      redirect_to @user, :notice => 'Welcome aboard!'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
