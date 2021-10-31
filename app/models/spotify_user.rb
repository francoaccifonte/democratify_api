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
#  spotify_id               :string           not null
#
class SpotifyUser < ApplicationRecord
  has_many :playlists, dependent: :destroy

  delegate :playlists, to: :client

  def client
    @client ||= Spotify::Client.new(
      access_token: access_token,
      refresh_token: refresh_token,
    )
  end

  def refresh_access_token
    return unless access_token_expired?

    refresh_access_token!
  end

  private

  def refresh_access_token!
    client.refresh_access_token!
    response = client.refresh_access_token!

    self.access_token = response.fetch(:access_token)
    self.access_token_expires_at = Time.now + response.fetch(:expires_in).seconds
    save!
  end

  def access_token_expired?
    access_token_expires_at < Time.now - 5.minutes
  end
end
