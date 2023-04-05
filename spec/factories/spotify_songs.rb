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
FactoryBot.define do
  factory :spotify_song do
    album { Faker::Music.album }
    artist { Faker::Music.band }
    cover_art do
      [64, 300, 640].map do |size|
        {
          url: Faker::Internet.url,
          width: size,
          height: size
        }
      end
    end
    duration { Faker::Number.number(digits: 3).to_i }
    genre { Faker::Music.genre }
    title { Faker::Music::RockBand.song }
    uri { Faker::Internet.url }
    external_id { Faker::Number.number(digits: 10).to_s }
  end
end
