# == Schema Information
#
# Table name: songs
#
#  id                  :bigint           not null, primary key
#  album               :string
#  artist              :string           not null
#  genre               :string
#  metadata            :jsonb
#  title               :string           not null
#  year                :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  spotify_playlist_id :bigint
#
# Indexes
#
#  index_songs_on_album                (album)
#  index_songs_on_artist               (artist)
#  index_songs_on_spotify_playlist_id  (spotify_playlist_id)
#  index_songs_on_title                (title)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
class Song < ApplicationRecord
end
