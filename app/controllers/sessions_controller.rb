class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, :notice => 'Hi there'
    else
      flash.now.alert = 'Could not log you in'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Smell you later'
  end

  # a way for mta to verify a user's login details. requires plain text username & password.
  def auth
    # mta-specific json handling
    if params[:name].nil? and params[:password].nil?
      begin
        array = JSON.parse request.body.read
        params[:name] = array[0]
        params[:password] = array[1]
      rescue JSON::ParseError
      end
    end
    # end of handling
    respond_to do |format|
      format.json {
        user = User.find_by_name(params[:name])
        if user && user.authenticate(params[:password])
          render :json => [user], :only => [:admin, :name, :id]
        else
          head :forbidden
        end
      }
      format.any { head :bad_request }
    end
  end
end
