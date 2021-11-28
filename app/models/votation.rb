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
class Votation < ApplicationRecord
  delegate :pool_size, to: :ongoing_playlist

  belongs_to :account
  belongs_to :ongoing_playlist

  has_many :votation_candidates, dependent: :destroy, foreign_key: :votation_id

  before_validation :set_account, on: :create
  before_validation :set_queued, on: :create
  before_validation :set_timestamps, on: :create

  validate :less_than_two_votations, on: :create
  validate :right_ammount_of_candidates, on: :create

  after_save :set_candidates
  after_save :schedule_close

  scope :in_progress, -> { where(in_progress: true) }
  scope :queued, -> { where(queued: true) }

  def winner
    votation_candidates.max_by(&:votes)
  end

  private

  def set_candidates
    ongoing_playlist.spotify_playlist_songs.sample(pool_size).each do |spotify_playlist_song|
      votation_candidates.create!(
        spotify_playlist_song: spotify_playlist_song,
        account: account,
        ongoing_playlist: ongoing_playlist
      )
    end
  end

  def set_queued
    return unless queued.nil?

    self.queued = ongoing_playlist.votations.pluck(:in_progress).any?
    self.in_progress = !queued
  end

  def set_timestamps(current_time: Time.zone.now)
    self.scheduled_end_at = current_time
    self.scheduled_start_at = current_time
    self.scheduled_start_for ||= current_time
    self.scheduled_end_for ||= scheduled_start_for + (ongoing_playlist.playing_song.duration / 1000).seconds
    self.scheduled_close_for ||= scheduled_start_for + ((ongoing_playlist.playing_song.duration / 1000) * 0.8).to_i.seconds
  end

  def set_account
    self.account_id = ongoing_playlist.account_id
  end

  def less_than_two_votations
    return if ongoing_playlist.votations.count <= 2

    errors.add(:ongoing_playlist, 'cant have more than two votations')
  end

  def right_ammount_of_candidates
    return if [0, pool_size].include?(votation_candidates.count)

    errors.add(:votation_candidates, "must have 0 or #{pool_size} candidates")
  end

  def schedule_close
    VotationTransitionWorker.perform_at(scheduled_close_for, ongoing_playlist_id)
  end
end
