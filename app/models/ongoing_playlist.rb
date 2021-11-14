# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  spotify_playlists_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id            (account_id)
#  index_ongoing_playlists_on_spotify_playlists_id  (spotify_playlists_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_playlists_id => spotify_playlists.id)
#
class OngoingPlaylist < ApplicationRecord
end
