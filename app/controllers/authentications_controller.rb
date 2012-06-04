class AuthenticationsController < ApplicationController
  def show
    omniauth = request.env["omniauth.auth"]
    raise omniauth.inspect

  end 
end
