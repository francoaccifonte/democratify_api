# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  spotify_playlist_id :bigint           not null
#  spotify_song_id     :bigint
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#  index_ongoing_playlists_on_spotify_song_id                     (spotify_song_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#  fk_rails_...  (spotify_song_id => spotify_songs.id)
#
class OngoingPlaylist < ApplicationRecord
  attr_accessor :previous_playlist

  belongs_to :account
  belongs_to :spotify_playlist
  belongs_to :playing_song, class_name: 'SpotifySong', optional: true, foreign_key: :spotify_song_id

  has_many :spotify_songs, through: :spotify_playlist
  has_many :votations, dependent: :destroy
  has_many :votation_candidates, through: :votations

  validate :playing_song_is_in_playlist

  private

  def playing_song_is_in_playlist
    return unless playing_song.present?
    return if spotify_songs.pluck(:id).include?(playing_song.id)

    errors.add(:playing_song, 'is not in the playlist')
  end
end
