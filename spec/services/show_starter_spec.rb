require 'rails_helper'

describe ShowStarter do
  subject { described_class.call(account:, spotify_playlist:) }

  let!(:account) { create(:account) }
  let!(:spotify_user) { create(:spotify_user, account:) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:, spotify_user:, song_count: 20) }

  let!(:devices_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player/devices").to_return(status: 200, body: JSON.unparse(device_response)) }
  let!(:add_to_queue_stub) { stub_request(:post, %r{https://api.spotify.com/v1/me/player/queue?}).to_return(status: 200, body: "", headers: {}) }
  let!(:get_player_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player?fields=item(device(id,is_active,name,volume_percent),shuffle_state,progress_ms,is_playing,item(duration_ms))").to_return(status: 200, body: "", headers: {}) }

  context 'when user is listening from a remote device' do
    let(:device_response) { { devices: [{ id: 123, is_active: true }] } }

    it 'creates the ongoing_playlist' do
      expect { subject }.to change(OngoingPlaylist, :count).by(1)
      expect(OngoingPlaylist.last.account_id).to eq(account.id)
    end

    it 'assigns the correct spotify_playlist' do
      subject
      expect(OngoingPlaylist.last.spotify_playlist.id).to eq(spotify_playlist.id)
    end

    it 'creates a votation' do
      expect { subject }.to change(Votation, :count).by(1)
      expect(Votation.last.account_id).to eq(account.id)
    end

    it 'has the correct ammount of voting songs / candidates' do
      subject
      expect(OngoingPlaylist.last.voting_songs.count).to eq(subject.pool_size)
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
