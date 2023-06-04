require "rails_helper"

RSpec.describe VotationsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/votations/1").to route_to("votations#show", id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/votations/1").to route_to("votations#update", id: "1")
    end
  end
end
