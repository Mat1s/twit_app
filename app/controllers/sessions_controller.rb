class SessionsController < ApplicationController
  
  def create
    @user = User.find_or_create_by_auth(request.env["omniauth.auth"])
  	session[:current_user] = @user.id
  	flash[:success] = "User successfully authenticate"
  	redirect_to root_url 
  end

  def destroy
  	session[:current_user] = nil
  	flash[:warning] = "User closed your session"
  	redirect_to root_url
  end

  protected

  def auth_hash
  	request.env['omniauth.auth']
  end
end
