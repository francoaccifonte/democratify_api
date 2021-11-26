# frozen_string_literal: true

module Spotify
  module RemotePlayer
    extend ActiveSupport::Concern

    def playback_state
      fields = 'item(device(id,is_active,name,volume_percent),shuffle_state,progress_ms,is_playing,item(duration_ms))'
      get("#{self.class::SPOTIFY_URL}/me/player?fields=#{fields}")
    end

    def transfer_playback(device_id)
      put("#{self.class::SPOTIFY_URL}/me/player", body: { device_ids: [device_id] })
    end

    def list_devices
      get("#{self.class::SPOTIFY_URL}/me/player/devices").fetch(:devices)
    end

    def add_to_playback_queue(uri, device_id)
      post("#{self.class::SPOTIFY_URL}/me/player/queue?uri=#{uri}&device_id=#{device_id}", body: { uris: [uri] })
    end
  end
end
