# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint
#
# Indexes
#
#  index_playlists_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class PlaylistSerializer < Panko::Serializer
  attributes :id, :description, :name, :created_at, :updated_at, :account_id

  has_many :songs, serializer: SongSerializer
end
