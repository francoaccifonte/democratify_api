# == Schema Information
#
# Table name: spotify_songs
#
#  id                  :bigint           not null, primary key
#  album               :string
#  artist              :string           not null
#  cover_art           :jsonb
#  duration            :float
#  genre               :string
#  metadata            :jsonb
#  title               :string           not null
#  uri                 :string           not null
#  year                :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  external_id         :string           not null
#  spotify_playlist_id :bigint
#
# Indexes
#
#  index_spotify_songs_on_album                (album)
#  index_spotify_songs_on_artist               (artist)
#  index_spotify_songs_on_external_id          (external_id)
#  index_spotify_songs_on_spotify_playlist_id  (spotify_playlist_id)
#  index_spotify_songs_on_title                (title)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
class SpotifySong < ApplicationRecord
  include Spotifiable
  include Spotifiable::SongSpotifiable

  belongs_to :spotify_playlist

  has_many :votation_candidates, dependent: :destroy

  delegate :account, to: :spotify_playlist
end
