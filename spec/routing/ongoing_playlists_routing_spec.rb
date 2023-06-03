require "rails_helper"

RSpec.describe OngoingPlaylistsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ongoing_playlists').to route_to('ongoing_playlists#index')
    end
  end
end
