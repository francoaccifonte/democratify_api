require "rails_helper"

RSpec.describe SpotifyPlaylistsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/spotify_playlists").to route_to("spotify_playlists#index")
    end

    it "routes to #show" do
      expect(get: "/spotify_playlists/1").to route_to("spotify_playlists#show", id: "1")
    end
  end
end
