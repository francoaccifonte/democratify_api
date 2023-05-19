# == Schema Information
#
# Table name: votations
#
#  id                  :bigint           not null, primary key
#  in_progress         :boolean          not null
#  queued              :boolean          not null
#  scheduled_close_for :datetime         not null
#  scheduled_end_at    :datetime         not null
#  scheduled_end_for   :datetime         not null
#  scheduled_start_at  :datetime         not null
#  scheduled_start_for :datetime         not null
#  started_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  ongoing_playlist_id :bigint           not null
#
# Indexes
#
#  index_votations_on_account_id                          (account_id)
#  index_votations_on_account_id_and_ongoing_playlist_id  (account_id,ongoing_playlist_id)
#  index_votations_on_ongoing_playlist_id                 (ongoing_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#
FactoryBot.define do
  factory :votation do
    in_progress { true }
    queued { false }
    scheduled_close_for { Time.current }
    scheduled_end_at { Time.current }
    scheduled_end_for { Time.current }
    scheduled_start_at { Time.current }
    scheduled_start_for { Time.current }
    started_at { Time.current }

    association :account, factory: :account
    association :ongoing_playlist, factory: :ongoing_playlist
  end
end
