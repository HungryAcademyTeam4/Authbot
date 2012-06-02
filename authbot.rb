#ENV['GOOGLE_AUTH_URL'] = 'https://www.google.com/accounts/o8/id'
require './setup'

get "/current_user" do
  if session["user_id"]
    user = User.find(session["user_id"])
    body "<ul><li id='email'>#{ user.email }</li></ul>"
  else
    terminate_sessions
  end
end

get '/' do
  auth_data = Authenticator.auth || session["user_info"]
  user_info  = JSON.parse(auth_data)
  email      = user_info["email"]

  if valid_domain?(email)
    session["user_id"] = User.id_for(user_info)
  else
    terminate_sessions
  end
end

def terminate_sessions
  session["user_info"] = nil
  session["user"] = nil
  status 401
end

def valid_domain?(email)
  VALID_DOMAINS.include?(email.split("@").last)
end