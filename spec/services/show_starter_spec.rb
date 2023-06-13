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

    it 'returns an OngoingPlaylist instance' do
      op = subject
      expect(op).to be_a(OngoingPlaylist)
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
      op = OngoingPlaylist.last
      expect(op.voting_songs.count).to eq(subject.pool_size)
      expect(op.voting_songs.map(&:spotify_song_id)).not_to include(SpotifyPlaylistSong.find(op.playing_song_id).spotify_song_id)
    end

    it 'has the correct candidates' do
      expected_candidates = spotify_playlist.spotify_playlist_songs.order(index: :asc)[1..OngoingPlaylist::DEFAULT_POOL_SIZE].pluck(:id)
      subject
      actual_candidates = OngoingPlaylist.last.votations.in_progress.first.votation_candidates.pluck(:spotify_playlist_song_id)
      expect(actual_candidates).to match_array(expected_candidates)
    end

    it 'starts playing the correct song' do
      subject
      expect(OngoingPlaylist.last.playing_song_id).to eq(spotify_playlist.spotify_playlist_songs.order(index: :asc).first.id)
    end

    it 'sends a song to the active remote' do
      subject
      assert_requested(devices_stub)
      assert_requested(add_to_queue_stub)
      assert_requested(get_player_stub)
    end
  end

  context 'when user is not using spotify on any device' do
    let(:device_response) { { devices: [] } }

    it 'does not create a new ongoing playlist' do
      prev_count = OngoingPlaylist.count
      expect { subject }.to raise_error(Spotify::Errors::DeviceNotFoundError)
      expect(OngoingPlaylist.count).to eq(prev_count)
    end

    it 'does not destroy existing ongoing playlist' do
      create(:ongoing_playlist, account:, spotify_playlist:)

      prev_ongoing_playlist_id = OngoingPlaylist.last.id
      expect { subject }.to raise_error(Spotify::Errors::DeviceNotFoundError)
      expect(OngoingPlaylist.last.id).to eq(prev_ongoing_playlist_id)
    end
  end
end
