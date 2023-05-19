require 'rails_helper'

describe ShowStarter do
  subject { described_class.call(account:, spotify_playlist:) }

  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, song_count: 20) }
  let!(:account) { spotify_playlist.account }
  let!(:spotify_user) { spotify_playlist.spotify_user }

  context 'when user is listening from a remote device' do
    it 'creates the ongoing_playlist' do
      byebug
      expect { subject }.to change(OngoingPlaylist, :count).by(1)

      playlist = OngoingPlaylist.last
      expect(playlist.account_id).to eq(account.id)
      expect(playlist.spotify_playlist.id).to eq(spotify_playlist.id)
    end

    it 'sends a song to the active remote' do
      instance = described_class.new(account:, spotify_playlist:)
      mock = instance_double(Spotify::Client, add_to_playback_queue: true)
      allow(instance).to receive(:client).and_return(mock)
      instance.call
      expect(mock).to have_received(:add_to_playback_queue)
    end
  end
end
