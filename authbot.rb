ENV['GOOGLE_AUTH_URL'] = 'https://www.google.com/accounts/o8/id'

require 'bundler'
Bundler.require
set :session_secret, 'HungryAcademy'

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
  email      = user_info["email"]
  first_name = user_info["first_name"]
  last_name  = user_info["last_name"]

  email_domain = email.split("@")[1]
  valid_email_domains = ['hungryacademy.org', 'livingsocial.com']

  user = User.find_by_email(user_info["email"])

  if valid_email_domains.include?(email_domain)
    unless user
      User.create(first_name: first_name,
                  last_name: last_name,
                  email: email)
    end
  else
    terminate_sessions
  end
end

def terminate_sessions
  session["user_info"] = nil
  session["user"] = nil
end