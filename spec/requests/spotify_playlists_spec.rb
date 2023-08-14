require 'rails_helper'

RSpec.describe '/spotify_playlists' do
  let(:account) { create(:account) }

  context 'when user is logged in' do
    before { WithAccountCookies.set_account_cookie(cookies, account) }

    context 'when account has a spotify user' do
      let!(:spotify_user) { create(:spotify_user, account:) }

      context 'with existing spotify_playlists' do
        let!(:spotify_playlists) { create(:spotify_playlist, account:) }

        it 'returns http success' do
          get spotify_playlists_url
          expect(response).to have_http_status(:success)
        end
      end

      context 'without existing spotify_playlists' do
        it 'returns http success' do
          get spotify_playlists_url
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid cookies' do
        it 'redirects to login and clears cookies' do
          account.update!(token: 'fakeToken')
          get spotify_playlists_url
          expect(response).to redirect_to(root_url)
          expect(response.cookies[:account_id]).to be_nil
          expect(response.cookies[:token]).to be_nil
        end
      end
    end

    context 'when account does not have a spotify user' do
      it 'redirects to account settings' do
        get spotify_playlists_url
        expect(response).to redirect_to(account_settings_url)
      end
    end
  end

  context 'when user is not logged in' do
    it 'redirects home' do
      get spotify_playlists_url
      expect(response).to redirect_to root_url
    end
  end
end
