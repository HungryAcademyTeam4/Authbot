require 'bundler'
Bundler.require

require './lib/user'
require './lib/authenticator'

set :session_secret, 'HungryAcademy'
enable :sessions

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite3",
)

VALID_DOMAINS = ['hungrymachine.com', 'livingsocial.com']
