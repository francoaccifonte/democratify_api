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
require 'rails_helper'

RSpec.describe SpotifySong do
  pending "add some examples to (or delete) #{__FILE__}"
end
