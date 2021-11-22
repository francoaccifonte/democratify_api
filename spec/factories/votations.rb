# == Schema Information
#
# Table name: votations
#
#  id                  :bigint           not null, primary key
#  in_progress         :boolean
#  queued              :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  accounts_id         :bigint
#  ongoing_playlist_id :bigint
#
# Indexes
#
#  index_votations_on_accounts_id          (accounts_id)
#  index_votations_on_ongoing_playlist_id  (ongoing_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#
FactoryBot.define do
  factory :votation do
    
  end
end
