# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  song_id     :bigint
#
# Indexes
#
#  index_playlists_on_song_id  (song_id)
#
# Foreign Keys
#
#  fk_rails_...  (song_id => songs.id)
#
require 'rails_helper'

RSpec.describe Playlist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
