class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth

  def new
  end

  def create
    user = User.find_by_name(params[:name]) unless params[:name].blank?
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, :notice => 'Hi there'
    else
      flash[:error] = 'Could not log you in'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Smell you later'
  end

  # a way for mta to verify a user's login details. requires plain text username & password.
  def auth
    respond_to do |format|
      format.json {
        # this should not be made available for public (for everyone to call), since it requires the user to enter a
        # plaintext-password on a third party site.
        # If we (ever) want logins via other websites (for example an external map app
        # as once existed for vG; though that had no logins) OAuth2 should be used.
        head :forbidden unless request.remote_ip == "127.0.0.1"

        user = User.find_by_name(params[:name]) unless params[:name].blank?
        if user && user.authenticate(params[:password])
          render :json => user, :only => [:admin, :name, :id]
        else
          head :forbidden
        end
      }
      format.any { head :bad_request }
    end
  end
end
