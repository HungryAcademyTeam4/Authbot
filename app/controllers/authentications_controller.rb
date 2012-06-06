class AuthenticationsController < ApplicationController
  def index
    #test line
    redirect_to "www.cnn.com"
  end

  def create
    @omniauth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_auth(@omniauth)
    set_cookie(@user) if @user
    #SHIPIT
    return redirect_to root_url(port: 80, only_path: false)
  end 

  def destroy
    cookies.delete("uid")
  end

  def set_cookie(user)
    cookies["uid"] = user.uid
  end 
end
