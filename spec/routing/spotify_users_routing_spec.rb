require "rails_helper"

RSpec.describe SpotifyUsersController do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/spotify_users").to route_to("spotify_users#create")
    end
  end
end
