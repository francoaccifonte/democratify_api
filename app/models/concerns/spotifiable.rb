# frozen_string_literal: true

module Spotifiable
  extend ActiveSupport::Concern

  def spotify_client
    fetch_client
  end

  def active_device
    @active_device ||= active_spotify_user.spotify_devices.selected.first
  end

  private

  def active_spotify_user
    @active_spotify_user ||= account.spotify_users.first
  end

  def fetch_client
    active_spotify_user.client
  end
end
