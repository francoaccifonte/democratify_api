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
class VotationSerializer < Panko::Serializer
  attributes :id, :in_progress, :queued,
             :scheduled_close_for, :scheduled_end_at, :scheduled_end_for, :scheduled_start_at, :scheduled_start_for,
             :started_at, :created_at, :updated_at,
             :account_id, :ongoing_playlist_id

  has_many :votation_candidates, serializer: VotationCandidateSerializer
end
