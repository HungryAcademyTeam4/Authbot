require './spec/acceptance_helper'

describe "authbot" do
  context "new user signs in successfully" do
    it "creates a new user" do
      Authenticator.stub(:auth).and_return({:email => "michael.verdi@hungrymachine.com"}.to_json)
      visit '/'
      visit '/current_user'
      within("#email") do
        page.should have_content("michael.verdi@hungrymachine.com")
      end
    end
  end

  context "new user signs in with non-approved email domain" do
    it "does not create a new user" do
      Authenticator.stub(:auth).and_return({:email => "michael.verdi@groupon.com"}.to_json)
      visit '/'
      page.driver.response.status.should be 401
    end
  end
end
