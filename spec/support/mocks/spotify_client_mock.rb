# frozen_string_literal: true

RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'with mocked spotify client', shared_context: :metadata do
  def mock_user(client = nil)
    allow(Spotify::Client).to receive(:new).and_return(client || mocked_client)
  end

  def mocked_client(response = {})
    defaults = {
      list_devices: list_devices,
      add_to_playback_queue: '',
      add_to_active_playback_queue!: '',
      playing_song_remaining_time: 30.seconds
    }.merge!(response).compact
    instance_double(
      Spotify::Client,
      **defaults
    )
  end

  def list_devices
    [{
      id: '919124d67f96cadf93514836d4e45c69b3eba96c',
      is_active: true,
      is_private_session: false,
      is_restricted: false,
      name: 'Redmi Note 5',
      type: 'Smartphone',
      volume_percent: 100
    }]
  end
end
