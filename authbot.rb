ENV['GOOGLE_AUTH_URL'] = 'https://www.google.com/accounts/o8/id'

require 'sinatra'
require 'sinatra/google-auth'


get '/' do
  authenticate
  'Hello'
end