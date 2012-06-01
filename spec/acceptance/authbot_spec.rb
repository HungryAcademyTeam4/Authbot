require 'spec/helper'

set :environment, :test
Test::Unit::TestCase.send :include, Rack::Test::Methods

def app
  Sinatra::Application
end

describe "authbot" do
  before(:each) do
    visit '/'
  end

  context "existing user signs in" do
    it "creates a cookie with the user's email" do
      login_with_google
      session["user"].should == "michael.verdi@hungrymachine.com"
    end
  end

  context "new user signs in successfully" do
    it "creates a new user and sets a cookie with the user's email" do
      login_with_google
      session["user"].should == "michael.verdi@hungrymachine.com"
      user = User.find_by_email(session["user"])
      user.first_name.should == "michael"
    end
  end

  context "new user signs in with non-approved email domain" do
    it "does not create a new session or create a user" do
      invalid_login_with_google
      session["user"].should be_nil
      session["user_info"].should be_nil
    end
  end

end
