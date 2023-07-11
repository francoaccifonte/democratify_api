require 'rails_helper'

RSpec.describe '/spotify_playlists' do
  let!(:account) { create(:account) }
  let!(:user) { create(:spotify_user, account:) }

  context 'when user is logged in' do
    before { WithAccountCookies.set_account_cookie(cookies, account) }

    context 'with existing spotify_playlists' do
      let!(:spotify_playlists) { create(:spotify_playlist, account:, spotify_user: user) }

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

    context 'when user did not authorize us in spotify' do
      it 'redirects to account settings' do
        account.spotify_user.destroy!
        get spotify_playlists_url
        expect(response).to redirect_to(account_settings_path)
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
