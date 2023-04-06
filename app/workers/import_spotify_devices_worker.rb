# frozen_string_literal: true

class ImportSpotifyDevicesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :spotify_import

  def perform(user_id)
    user = SpotifyUser.find(user_id)

    ActiveRecord::Base.transaction do
      user.spotify_devices.destroy_all

      user.list_devices.each do |remote_device|
        user.spotify_devices.create!(
          device_params(remote_device)
        )
      end
    end
  end

  def device_params(remote_device)
    {
      is_active: remote_device.fetch(:is_active),
      is_private_session: remote_device.fetch(:is_private_session),
      is_restricted: remote_device.fetch(:is_restricted),
      name: remote_device.fetch(:name),
      device_type: remote_device.fetch(:type),
      external_id: remote_device.fetch(:id),
      is_selected: remote_device.fetch(:is_active)
    }
  end
end
