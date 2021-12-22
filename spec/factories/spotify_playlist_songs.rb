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
#  index_spotify_playlist_songs_on_spotify_playlist_id_and_index  (spotify_playlist_id,index)
#  index_spotify_playlist_songs_on_spotify_song_id                (spotify_song_id)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#  fk_rails_...  (spotify_song_id => spotify_songs.id)
#
FactoryBot.define do
  factory :spotify_playlist_song do
    association :spotify_playlist, factory: :spotify_playlist
    association :spotify_song, factory: :spotify_song
  end
end
