# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  spotify_playlist_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
class OngoingPlaylistSerializer < Panko::Serializer
  attributes :id, :created_at, :updated_at

  has_one :account, serializer: AccountSerializer
  has_one :spotify_playlist, serializer: SpotifyPlaylistSerializer
  has_many :spotify_songs, serializer: SpotifySongSerializer
end
