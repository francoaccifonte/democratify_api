# == Schema Information
#
# Table name: spotify_songs
#
#  id          :bigint           not null, primary key
#  album       :string
#  artist      :string           not null
#  cover_art   :jsonb
#  duration    :float
#  genre       :string
#  metadata    :jsonb
#  title       :string           not null
#  uri         :string           not null
#  year        :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :string           not null
#
# Indexes
#
#  index_spotify_songs_on_album        (album)
#  index_spotify_songs_on_artist       (artist)
#  index_spotify_songs_on_external_id  (external_id)
#  index_spotify_songs_on_title        (title)
#
class SpotifySongSerializer < Panko::Serializer
  attributes :id, :uri, :album, :artist, :cover_art, :duration, :genre, :metadata, :title, :year,
             :created_at, :updated_at, :external_id
end
