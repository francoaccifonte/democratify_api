require 'rails_helper'

describe ShowStarter do
  subject { described_class.call(account:, spotify_playlist:) }

  let!(:account) { create(:account) }
  let!(:spotify_user) { create(:spotify_user, account:) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:, spotify_user:, song_count: 20) }
  # let!(:mocked_client) { instance_double(Spotify::Client) }

  # before do
  #   allow(mocked_client).to receive(:add_to_active_playback_queue!).with(anything).and_return(true)
  #   allow(mocked_client).to receive(:refresh_access_token!).and_return(true)
  #   allow(mocked_client).to receive(:playing_song_remaining_time).and_return(96.seconds)
  # end

  let!(:devices_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player/devices").to_return(status: 200, body: JSON.unparse(device_response)) }
  let!(:add_to_queue_stub) { stub_request(:post, %r{https://api.spotify.com/v1/me/player/queue?}).to_return(status: 200, body: "", headers: {}) }
  let!(:get_player_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player?fields=item(device(id,is_active,name,volume_percent),shuffle_state,progress_ms,is_playing,item(duration_ms))").to_return(status: 200, body: "", headers: {}) }

  context 'when user is listening from a remote device' do
    let(:device_response) { { devices: [{ id: 123, is_active: true }] } }

    it 'creates the ongoing_playlist' do
      expect { subject }.to change(OngoingPlaylist, :count).by(1)
      playlist = OngoingPlaylist.last

      expect(playlist.account_id).to eq(account.id)
      expect(playlist.spotify_playlist.id).to eq(spotify_playlist.id)
    end

    it 'sends a song to the active remote' do
      subject
      assert_requested(devices_stub)
      assert_requested(add_to_queue_stub)
      assert_requested(get_player_stub)
    end
  end

  context 'when user is not using spotify on any device' do
    pending 'handle this case, it will probably happen often'
  end
end
