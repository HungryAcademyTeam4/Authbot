class AuthenticationsController < ApplicationController
  def create
    @omniauth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_auth(@omniauth)
    set_cookie(@user) if @user
    #SHIPIT
    return redirect_to("http://fallinggarden.com:80")
  end 

  def destroy
    cookies.delete("uid")
  end

  def set_cookie(user)
    cookies["uid"] = user.uid
  end 


end
