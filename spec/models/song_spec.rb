# == Schema Information
#
# Table name: songs
#
#  id          :bigint           not null, primary key
#  album       :string
#  artist      :string           not null
#  genre       :string
#  metadata    :jsonb
#  title       :string           not null
#  year        :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  playlist_id :bigint
#
# Indexes
#
#  index_songs_on_album        (album)
#  index_songs_on_artist       (artist)
#  index_songs_on_playlist_id  (playlist_id)
#  index_songs_on_title        (title)
#
# Foreign Keys
#
#  fk_rails_...  (playlist_id => playlists.id)
#
require 'rails_helper'

RSpec.describe Song, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
