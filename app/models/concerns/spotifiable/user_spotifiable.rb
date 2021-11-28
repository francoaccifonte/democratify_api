# frozen_string_literal: true

module Spotifiable
  module UserSpotifiable
    extend ActiveSupport::Concern

    def send_to_remote
      spotify_client.add_to_playback_queue(uri, list_devices.first.fetch(:id))
    end

    def list_devices
      spotify_client.list_devices
    end
  end
end
