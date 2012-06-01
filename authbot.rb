ENV['GOOGLE_AUTH_URL'] = 'https://www.google.com/accounts/o8/id'

require 'bundler'
Bundler.require 

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/database.yml",
)

enable :sessions

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email
end

get '/' do
  authenticate
  user_info  = JSON.parse(session["user_info"])
  user       = User.find_by_email(user_info["email"])
  email      = user_info["email"] 
  first_name = user_info["first_name"] 
  last_name  = user_info["last_name"] 

  unless user
    User.create(first_name: first_name,
                last_name: last_name,
                email: email)
  end
end