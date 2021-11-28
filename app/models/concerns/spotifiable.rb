# frozen_string_literal: true

module Spotifiable
  extend ActiveSupport::Concern

  def spotify_client
    @spotify_client ||= fetch_client
  end

  def active_device
    @active_device ||= active_spotify_user.spotify_devices.selected.first
  end

  private

  def active_spotify_user
    @active_spotify_user ||= account.spotify_users.first
  end

  def fetch_client
    Spotify::Client.new(
      user: active_spotify_user,
      access_token: active_spotify_user.access_token,
      refresh_token: active_spotify_user.refresh_token
    )
  end
end
