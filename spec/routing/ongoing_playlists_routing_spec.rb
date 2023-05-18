require "rails_helper"

RSpec.describe OngoingPlaylistsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ongoing_playlists").to route_to("ongoing_playlists#index")
    end

    it "routes to #create" do
      expect(post: "/ongoing_playlists").to route_to("ongoing_playlists#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ongoing_playlists/1").to route_to("ongoing_playlists#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ongoing_playlists/1").to route_to("ongoing_playlists#destroy", id: "1")
    end
  end
end
