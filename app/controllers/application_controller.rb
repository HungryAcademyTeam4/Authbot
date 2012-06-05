class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user 
    if session["uid"]
      user = User.find_by_uid(session["uid"])
    end 
    user
  end 

  helper_method :current_user


end
