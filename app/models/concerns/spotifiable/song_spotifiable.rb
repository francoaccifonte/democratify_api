# frozen_string_literal: true

module Spotifiable
  module SongSpotifiable
    extend ActiveSupport::Concern

    def send_to_active_remote
      spotify_client.add_to_playback_queue(uri, active_device.external_id)
    end
  end
end
