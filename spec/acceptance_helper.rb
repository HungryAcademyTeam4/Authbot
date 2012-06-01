require File.dirname(__FILE__) + '/spec_helper'
require Sinatra::Application.root + '/app'
disable :run

require 'capybara'
require 'capybara/dsl'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara
end

def login_with_google
  visit '/'
  fill_in 'email',  :with => "michael.verdi@hungrymachine.com"
  fill_in 'password',   :with => "chinese22"
  click 'allow'
end

def invalide_login_with_google
  visit '/'
  fill_in 'email',  :with => "michael.v.verdi@gmail.com"
  fill_in 'password',   :with => "chinese22"
  click 'allow'
end


# before(:each) do
#   User.stub(:login).and_return(File.open("/url/to/file/with/json"))
# end