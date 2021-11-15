# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  spotify_playlist_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
FactoryBot.define do
  factory :ongoing_playlist do
    
  end
end
