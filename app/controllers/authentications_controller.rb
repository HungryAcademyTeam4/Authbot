class AuthenticationsController < ApplicationController
  def index
    # This will never get hit; this is merely a placeholder for
    # a root_path whose responsibility is to redirect to the main app.
  end

  def create
    @omniauth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_auth(@omniauth)
    set_cookie(@user) if @user
    return redirect_to root_url(port: 80, only_path: false)
  end 

  def destroy
    cookies.delete("uid")
  end

  def set_cookie(user)
    cookies["uid"] = user.uid
  end 
end
