require 'bundler/setup'

require 'sinatra'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment


#require 'bundler'
#Bundler.require #[:default, :test] #, Sinatra::Application.environment

require './authbot.rb'
Capybara.app = Sinatra::Application

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.include Capybara
end

def login_with_google
  visit '/'
  fill_in 'Email',  :with => "michael.verdi@hungrymachine.com"
  fill_in 'Passwd',   :with => "chinese22"
  click 'allow'
end

def invalid_login_with_google
  visit '/'
  fill_in 'Email',  :with => "michael.v.verdi@gmail.com"
  fill_in 'Passwd',   :with => "chinese22"
  click 'allow'
end


# before(:each) do
#   User.stub(:login).and_return(File.open("/url/to/file/with/json"))
# end