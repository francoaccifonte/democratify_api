require 'rails_helper'

describe SpotifyUserCreator do
  subject { described_class.call(account_id: account.id, code:) }

  let!(:account) { create(:account) }
  let(:code) { Faker::Lorem.characters(number: 50) }
  let(:auth_body) do
    JSON.unparse(
      {
        scope: 'some_scope',
        access_token: 'some_access_token',
        expires_in: 3600,
        refresh_token: 'some_refresh_token'
      }
    )
  end
  let(:user_body) do
    JSON.unparse(
      {
        id: Faker::Number.number(digits: 10).to_s,
        display_name: Faker::Name.name,
        email: Faker::Internet.email,
        uri: Faker::Internet.url,
        href: Faker::Internet.url
      }
    )
  end

  before do
    stub_request(:post, "https://accounts.spotify.com/api/token")
      .to_return(status: 200, body: auth_body, headers: {})

    stub_request(:get, "https://api.spotify.com/v1/me")
      .to_return(status: 200, body: user_body, headers: {})
  end

  context 'when all goes well' do
    it 'creates the user' do
      expect { subject }.to change(SpotifyUser, :count).by(1)
      user = account.spotify_user.reload
      expect(user.scope).to eq('some_scope')
      expect(user.access_token).to eq('some_access_token')
      expect(user.refresh_token).to eq('some_refresh_token')

      user_hash = JSON.parse(user_body).symbolize_keys
      expect(user.spotify_id).to eq(user_hash[:id])
      expect(user.name).to eq(user_hash[:display_name])
      expect(user.email).to eq(user_hash[:email])
      expect(user.uri).to eq(user_hash[:uri])
      expect(user.href).to eq(user_hash[:href])
    end

    it 'enqueues a PlaylistImportWorker' do
      expect { subject }.to change(PlaylistImportWorker.jobs, :size).by(1)
    end
  end
end
