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
#  index_spotify_users_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class SpotifyUser < ApplicationRecord
  has_many :spotify_playlists, dependent: :destroy # TODO: playlists are not destroyed when the user is deleted
  has_many :spotify_devices, dependent: :destroy

  belongs_to :account

  delegate :playlists, to: :client

  after_create :import_playlists

  def self.authorize_and_create(account_id:, code:)
    new_user = new(account_id: account_id)
    new_user.spotify_client.login_token = code
    auth_response = new_user.spotify_client.authorize
    new_user.access_token = auth_response[:access_token]

    user_data = new_user.spotify_client.user

    new_user.assign_attributes(
      spotify_id: user_data[:id],
      name: user_data[:display_name],
      email: user_data[:email],
      uri: user_data[:uri],
      scope: auth_response[:scope],
      access_token: auth_response[:access_token],
      access_token_expires_at: Time.zone.now + auth_response[:expires_in].seconds,
      refresh_token: auth_response[:refresh_token],
      href: user_data[:href]
    )
    new_user.save!
  end

  def client # TODO: remove this method and keep spotify_client
    @client ||= Spotify::Client.new(user: self)
    refresh_access_token
    @client
  end

  def spotify_client
    client
  end

  def refresh_access_token
    return unless access_token_expired?

    refresh_access_token!
  end

  def sync_devices(async: false)
    return ImportSpotifyDevicesWorker.perform_async(id) if async

    ImportSpotifyDevicesWorker.new.perform(id)
  end

  def access_token_expired?
    return false unless access_token_expires_at

    access_token_expires_at < Time.now - 5.minutes
  end

  private

  def refresh_access_token!
    response = @client.refresh_access_token!

    self.access_token = response.fetch(:access_token)
    self.access_token_expires_at = Time.now + response.fetch(:expires_in).seconds
    save!
  end

  def import_playlists
    PlaylistImportWorker.perform_async(id)
  end

  def fetch_client
    client
  end
end
