# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::WebhookController do
  include_context 'with mocked spotify client'

  describe 'GET /index' do
    subject do
      get(api_spotify_login_path, params:)
    end

    let(:params) { nil }
    let(:account) { create(:account) }

    context 'when the request is correct' do
      let!(:params) { { state: account.id, code: 'farafa' } }
      let!(:mock) do
        mocked_client(
          authorize: {
            access_token: 'fake_access_token',
            scope: 'fake_scope',
            expires_in: 3600,
            refresh_token: 'fake_access_token'
          },
          user: {
            id: 'fake_id',
            display_name: 'fake_user_name',
            email: 'fake@email.spotify',
            uri: 'https://fake.user.uri',
            href: 'https://fake.user.href'
          },
          'login_token=': ''
        )
      end

      before { mock_user(mock) }

      it 'creates the spotify user' do
        expect { subject }.to change(SpotifyUser, :count).by(1)
      end
    end
  end
end
