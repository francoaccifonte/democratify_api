require "rails_helper"

RSpec.describe AccountSettingsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/account_settings").to route_to("account_settings#index")
    end
  end
end
