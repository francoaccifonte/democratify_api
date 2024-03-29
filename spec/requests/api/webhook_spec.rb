# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::WebhookController do
  include_context 'with mocked spotify client'

  describe 'GET /index' do
    subject do
      get(spotify_login_path, params:)
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
            refresh_token: 'fake_refresh_token'
          },
          user: {
            id: 'fake_id',
            display_name: 'fake_user_name',
            email: 'fake@email.spotify',
            uri: 'https://fake.user.uri',
            href: 'https://fake.user.href'
          },
          'login_token=': '',
          'access_token=': '',
          'refresh_token=': ''
        )
      end

      before do
        mock_user(mock)
        allow(SpotifyUserAuthorizer).to receive(:call)
      end

      it 'creates the spotify user' do
        subject
        expect(SpotifyUserAuthorizer).to have_received(:call).with(account_id: account.id.to_s, code: 'farafa')
      end

      it 'redirects to the playlist selection view' do
        subject
        expect(response).to redirect_to(spotify_playlists_url)
      end
    end
  end
end
