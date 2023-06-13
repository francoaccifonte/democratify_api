# == Schema Information
#
# Table name: spotify_playlist_songs
#
#  id                  :bigint           not null, primary key
#  enqueued_at         :datetime
#  index               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  spotify_playlist_id :bigint           not null
#  spotify_song_id     :bigint           not null
#
# Indexes
#
#  index_spotify_playlist_songs_on_spotify_playlist_id            (spotify_playlist_id)
#  index_spotify_playlist_songs_on_spotify_playlist_id_and_index  (spotify_playlist_id,index) UNIQUE
#  index_spotify_playlist_songs_on_spotify_song_id                (spotify_song_id)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#  fk_rails_...  (spotify_song_id => spotify_songs.id)
#
require 'rails_helper'

RSpec.describe SpotifyPlaylistSong do
  let!(:account) { create(:account) }
  let!(:spotify_user) { create(:spotify_user, account:) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:, spotify_user:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, account:, spotify_playlist:) }
  let!(:new_spotify_song) { create(:spotify_song) }

  describe '#set_index' do
    context 'when no index is specified,' do
      it 'gives the correct index' do
        new_song = described_class.new(spotify_playlist:, spotify_song: new_spotify_song)
        new_song.save!
        expect(new_song.index).to eq(spotify_playlist.reload.spotify_playlist_songs.count)
      end
    end

    context 'when the index is specified' do
      it 'throws an error if it is invalid' do
        new_song = described_class.new(spotify_playlist:, spotify_song: new_spotify_song, index: 1)
        expect { new_song.save! }.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it 'can be valid' do
        new_song = described_class.new(spotify_playlist:, spotify_song: new_spotify_song, index: ongoing_playlist.spotify_playlist_songs.count + 3)
        expect(new_song.save!).to be_truthy
      end
    end
  end
end
