class AuthenticationsController < ApplicationController
  def create
    @omniauth = request.env["omniauth.auth"]
    @user = User.find_or_create_by_auth(@omniauth)
  end 
end
