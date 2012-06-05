class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user 
    if cookies["uid"]
      user = User.find_by_uid(cookies["uid"])
    end 
    user
  end 

  helper_method :current_user


end
