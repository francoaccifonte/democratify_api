require 'rails_helper'

class DummyHelper
  include AccountSettingsHelper
end

RSpec.describe AccountSettingsHelper do
  let(:account) { create(:account) }

  describe '.serialized_account' do
    subject { DummyHelper.new.serialized_account(account) }

    it 'provides a serialized account' do
      expect(subject).to include("\"id\":#{account.id}")
    end
  end

  describe '.spotify_redirect_uri' do
    before { stub_const('AccountSettingsHelper::SPOTIFY_CLIENT_ID', 'spotify_fake_client_id') }

    it 'returns the correct uri' do
      expect(DummyHelper.new.spotify_redirect_uri(account)).to eq(
        "https://accounts.spotify.com/authorize?response_type=code&client_id=spotify_fake_client_id&scope=user-read-email%20playlist-read-private%20playlist-read-collaborative%20user-read-playback-state%20user-modify-playback-state%20user-read-currently-playing&redirect_uri=http://localhost:3001/spotify_login&state=#{account.id}"
      )
    end
  end
end
