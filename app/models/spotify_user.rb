# == Schema Information
#
# Table name: spotify_users
#
#  id                       :bigint           not null, primary key
#  access_token             :string
#  access_token_expires_at  :datetime
#  email                    :string
#  href                     :string           not null
#  name                     :string
#  refresh_token            :string
#  refresh_token_expires_at :datetime
#  scope                    :string           not null
#  uri                      :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :bigint
#  spotify_id               :string           not null
#
# Indexes
#
#  index_spotify_users_on_account_id  (account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class SpotifyUser < ApplicationRecord
  has_many :spotify_playlists, dependent: :destroy # TODO: playlists are not destroyed when the user is deleted

  belongs_to :account

  delegate :playlists, to: :client

  after_create :import_playlists

  # TODO: remove this method and keep spotify_client
  def client
    @client ||= Spotify::Client.from_user(self)
    refresh_access_token
    @client
  end

  def spotify_client
    client
  end

  def refresh_access_token
    SpotifyUserTokenRefresher.call(user: self)
  end

  def sync_devices(async: false)
    return ImportSpotifyDevicesWorker.perform_async(id) if async

    ImportSpotifyDevicesWorker.new.perform(id)
  end

  def access_token_expired?
    return false unless access_token_expires_at

    access_token_expires_at < 5.minutes.ago
  end

  private

  def import_playlists
    PlaylistImportWorker.perform_async(id)
  end

  def fetch_client
    client
  end
end
