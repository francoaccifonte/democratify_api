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
class SpotifyPlaylistSongSerializer < Panko::Serializer
  attributes :id, :uri, :album, :artist, :cover_art, :duration, :genre, :metadata, :title, :year, :index,
             :created_at, :updated_at, :external_id,
             :spotify_playlist_id, :spotify_song_id, :enqueued_at

  def uri
    object.spotify_song.uri
  end

  def album
    object.spotify_song.album
  end

  def artist
    object.spotify_song.artist
  end

  def cover_art
    object.spotify_song.cover_art
  end

  def duration
    object.spotify_song.duration
  end

  def genre
    object.spotify_song.genre
  end

  def metadata
    object.spotify_song.metadata
  end

  def title
    object.spotify_song.title
  end

  def year
    object.spotify_song.year
  end

  def created_at
    object.spotify_song.created_at
  end

  def updated_at
    object.spotify_song.updated_at
  end

  def external_id
    object.spotify_song.external_id
  end
end
