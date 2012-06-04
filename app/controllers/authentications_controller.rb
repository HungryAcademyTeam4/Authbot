class AuthenticationsController < ApplicationController
  def create
    @omniauth = request.env["omniauth.auth"]
    @omniauth.inspect
  end 
end
