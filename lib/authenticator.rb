class Authenticator
  extend Sinatra::GoogleAuth::Helpers

  def self.auth
    authenticate
  end
end