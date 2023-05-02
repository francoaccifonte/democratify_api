require "rails_helper"

RSpec.describe AccountSettingsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/account_settings").to route_to("account_settings#index")
    end

    it "routes to #show" do
      expect(get: "/account_settings/1").to route_to("account_settings#show", id: "1")
    end
  end
end
