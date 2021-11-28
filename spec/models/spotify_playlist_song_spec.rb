# == Schema Information
#
# Table name: spotify_playlist_songs
#
#  id                  :bigint           not null, primary key
#  enqueued_at         :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  spotify_playlist_id :bigint           not null
#  spotify_song_id     :bigint           not null
#
# Indexes
#
#  index_spotify_playlist_songs_on_spotify_playlist_id  (spotify_playlist_id)
#  index_spotify_playlist_songs_on_spotify_song_id      (spotify_song_id)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#  fk_rails_...  (spotify_song_id => spotify_songs.id)
#
require 'rails_helper'

RSpec.describe SpotifyPlaylistSong, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end