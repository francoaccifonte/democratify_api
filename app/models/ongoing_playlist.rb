# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  pool_size           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  playing_song_id     :bigint           not null
#  spotify_playlist_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_playing_song_id                     (playing_song_id)
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (playing_song_id => spotify_playlist_songs.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
class OngoingPlaylist < ApplicationRecord
  attr_accessor :previous_playlist

  delegate :spotify_user, to: :account

  DEFAULT_POOL_SIZE = 3

  belongs_to :account
  belongs_to :spotify_playlist

  has_many :spotify_songs, through: :spotify_playlist
  has_many :votations, dependent: :destroy
  has_many :votation_candidates, through: :votations

  before_validation :set_pool_size, on: :create
  before_validation :set_playing_song, on: :create

  validate :playing_song_is_in_playlist

  delegate :spotify_playlist_songs, to: :spotify_playlist

  def user
    account.spotify_user
  end

  def voting_songs
    votations.in_progress.first.spotify_playlist_songs.order(index: :desc)
  end

  def remaining_songs
    spotify_playlist_songs.where.not(id: [playing_song.id, *voting_songs.pluck(:id)]).order(index: :asc)
  end

  def playing_song
    return unless playing_song_id

    spotify_playlist_songs.find(playing_song_id)
  end

  private

  def playing_song_is_in_playlist
    return if spotify_playlist_songs.exists?(playing_song.id)

    errors.add(:playing_song, 'is not in the playlist')
  end

  def set_pool_size
    return if pool_size.present?

    self.pool_size = DEFAULT_POOL_SIZE
  end

  def set_playing_song
    return if playing_song_id

    self.playing_song_id = spotify_playlist_songs.order(index: :asc).first.id
  end
end
