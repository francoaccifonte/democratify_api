require "rails_helper"

RSpec.describe VotationsController do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/accounts/1/votation").to route_to("votations#show", account_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/accounts/1/votation").to route_to("api/votations#vote", account_id: "1")
    end
  end
end
