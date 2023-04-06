# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  pool_size           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  playing_song_id     :bigint           not null
#  spotify_playlist_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_playing_song_id                     (playing_song_id)
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (playing_song_id => spotify_playlist_songs.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
class OngoingPlaylistSerializer < Panko::Serializer
  attributes :id, :pool_size, :created_at, :updated_at

  has_one :account, serializer: AccountSerializer
  has_one :spotify_playlist, serializer: SpotifyPlaylistSerializer, only: %i[id name description cover_art_url]
  has_one :playing_song, serializer: SpotifyPlaylistSongSerializer
  has_many :voting_songs, serializer: SpotifyPlaylistSongSerializer
  has_many :remaining_songs, serializer: SpotifyPlaylistSongSerializer

  def playing_song
    object.playing_song.spotify_song
  end

  def voting_songs
    object.votations.in_progress
  end

  delegate :remaining_songs, to: :object
end
