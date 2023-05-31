# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::OngoingPlaylistsController do
  describe 'POST /ongoing_playlists' do
    subject { post(api_ongoing_playlists_path, params:, headers: auth_headers) }

    let(:auth_headers) { { Authorization: "Bearer #{account.token}" } }
    let!(:account) { create(:account) }
    let!(:spotify_user) { create(:spotify_user, account:) }
    let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:, spotify_user:, song_count: 20) }

    let!(:devices_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player/devices").to_return(status: 200, body: JSON.unparse(device_response)) }
    let!(:add_to_queue_stub) { stub_request(:post, %r{https://api.spotify.com/v1/me/player/queue?}).to_return(status: 200, body: "", headers: {}) }
    let!(:get_player_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player?fields=item(device(id,is_active,name,volume_percent),shuffle_state,progress_ms,is_playing,item(duration_ms))").to_return(status: 200, body: "", headers: {}) }
    let(:params) { { spotify_playlist_id: spotify_playlist.id } }

    context 'when all goes well' do
      let(:device_response) { { devices: [{ id: 123, is_active: true }] } }

      it 'creates a new ongoing playlist' do
        expect { subject }.to change(OngoingPlaylist, :count).by(1)
      end
    end

    context 'when there is no active spotify device' do
      let(:device_response) { { devices: [] } }

      it 'returns an error' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
