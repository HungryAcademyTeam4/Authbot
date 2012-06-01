require_relative 'env' # Load env vars.
require_relative 'authbot/init' # Load app dependencies.

class AuthBot < Sinatra::Base
  register Sinatra::GoogleAuth

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

  run! if app_file == $0
end
