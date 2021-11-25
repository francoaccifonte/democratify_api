# == Schema Information
#
# Table name: votations
#
#  id                  :bigint           not null, primary key
#  in_progress         :boolean          not null
#  queued              :boolean          not null
#  scheduled_end_at    :datetime         not null
#  scheduled_end_for   :datetime         not null
#  scheduled_start_at  :datetime         not null
#  scheduled_start_for :datetime         not null
#  started_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  accounts_id         :bigint           not null
#  ongoing_playlist_id :bigint           not null
#
# Indexes
#
#  index_votations_on_accounts_id                          (accounts_id)
#  index_votations_on_accounts_id_and_ongoing_playlist_id  (accounts_id,ongoing_playlist_id)
#  index_votations_on_ongoing_playlist_id                  (ongoing_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#
class Votation < ApplicationRecord
  belongs_to :account
  belongs_to :ongoing_playlist

  has_many :votation_candidates, dependent: :destroy

  before_validation :set_queued, on: %i[create update]

  validate :less_than_two_votations, on: :create

  private

  def set_queued
    self.queued = ongoing_playlist.votations.pluck(:in_progress).any?
    self.in_progress = !queued
  end

  def less_than_two_votations
    return if ongoing_playlist.votations.count <= 2

    errors.add(:ongoing_playlist, 'cant have more than two votations')
  end
end
