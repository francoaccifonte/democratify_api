# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                       :bigint           not null, primary key
#  pool_size                :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :bigint           not null
#  spotify_playlist_id      :bigint           not null
#  spotify_playlist_song_id :bigint
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#  index_ongoing_playlists_on_spotify_playlist_song_id            (spotify_playlist_song_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#  fk_rails_...  (spotify_playlist_song_id => spotify_playlist_songs.id)
#
class OngoingPlaylist < ApplicationRecord
  attr_accessor :previous_playlist

  delegate :spotify_users, to: :account

  DEFAULT_POOL_SIZE = 3

  belongs_to :account
  belongs_to :spotify_playlist
  belongs_to :playing_song, class_name: 'SpotifyPlaylistSong', optional: true, foreign_key: :spotify_playlist_song_id

  has_many :spotify_songs, through: :spotify_playlist
  has_many :spotify_playlist_songs, through: :spotify_playlist
  has_many :votations, dependent: :destroy
  has_many :votation_candidates, through: :votations

  before_validation :set_pool_size, on: :create
  before_validation :set_playing_song, on: :create

  validate :playing_song_is_in_playlist

  after_create :start_initial_votation

  accepts_nested_attributes_for :spotify_playlist_songs

  def start_initial_votation(async: false)
    return InitialVotationStartWorker.perform_async(id) if async

    InitialVotationStartWorker.new.perform(id)
  end

  def playing_song_remaining_time
    user.client.playing_song_remaining_time
  end

  def user
    account.spotify_users.first
  end

  def voting_songs
    votations.in_progress.first.spotify_playlist_songs.order(index: :desc)
  end

  def remaining_songs
    spotify_playlist_songs.where.not(id: [playing_song.id, *voting_songs.pluck(:id)]).order(index: :asc)
  end

  private

  def playing_song_is_in_playlist
    return unless playing_song.present?
    return if spotify_playlist_songs.exists?(playing_song.id)

    errors.add(:playing_song, 'is not in the playlist')
  end

  def set_pool_size
    return if pool_size.present?

    self.pool_size = DEFAULT_POOL_SIZE
  end

  def set_playing_song
    return if playing_song.present?

    self.playing_song = spotify_playlist_songs.first
  end
end
