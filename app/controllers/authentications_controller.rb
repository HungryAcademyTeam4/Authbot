class AuthenticationsController < ApplicationController
  def create
    @omniauth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_auth(@omniauth)
    set_cookie(@user) if @user 
  end 

  def set_cookie(user)
    session["uid"] = user.uid
  end 
end
