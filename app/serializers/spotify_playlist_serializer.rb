# == Schema Information
#
# Table name: spotify_playlists
#
#  id              :bigint           not null, primary key
#  description     :string
#  external_url    :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  external_id     :string
#  spotify_user_id :bigint           not null
#
# Indexes
#
#  index_spotify_playlists_on_account_id       (account_id)
#  index_spotify_playlists_on_spotify_user_id  (spotify_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_user_id => spotify_users.id)
#
class SpotifyPlaylistSerializer < Panko::Serializer
  attributes :id, :description, :name, :created_at, :updated_at, :account_id, :external_id, :spotify_user_id

  # has_many :songs, serializer: SongSerializer
end
