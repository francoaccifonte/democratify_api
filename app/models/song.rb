# == Schema Information
#
# Table name: songs
#
#  id         :bigint           not null, primary key
#  album      :bigint
#  artist     :string           not null
#  genre      :string
#  metadata   :jsonb
#  title      :string           not null
#  year       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_songs_on_album   (album)
#  index_songs_on_artist  (artist)
#  index_songs_on_title   (title)
#
class Song < ApplicationRecord
end
