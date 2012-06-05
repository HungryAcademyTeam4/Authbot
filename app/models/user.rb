class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :uid

  def self.find_or_create_by_auth(auth)
    return nil unless passes_whitelist?(auth)
    user = User.find_by_uid(auth["uid"])
    unless user 
      user = User.create(:first_name => auth["info"]["first_name"], 
                         :last_name => auth["info"]["last_name"],
                         :email => auth["info"]["email"], 
                         :uid => auth["uid"])
    end 
    user
  end 

  def self.passes_whitelist?(auth)
    if auth["info"]["email"].split("@").last.upcase == "HUNGRYMACHINE.COM"
      true
    else 
      false
    end
  end 
end
