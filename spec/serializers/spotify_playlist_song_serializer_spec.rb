require 'rails_helper'

describe SpotifyPlaylistSongSerializer do
  subject { described_class.new.serialize_to_json(spotify_playlist_song) }

  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs) }
  let!(:spotify_playlist_song) { spotify_playlist.spotify_playlist_songs.first }

  it 'contains the correct attributes' do
    %i[id uri album artist cover_art duration genre metadata title year index created_at updated_at external_id spotify_playlist_id spotify_song_id enqueued_at].each do |attribute|
      expect(subject).to include("\"#{attribute}\":")
      expect(subject).to include(spotify_playlist_song.attributes[attribute].to_s) # if votation.attributes[attribute]
    end
  end
end
