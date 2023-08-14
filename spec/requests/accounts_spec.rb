require 'rails_helper'

RSpec.describe "Accounts" do
  let(:account) { create(:account) }

  describe "GET /accounts/login" do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies, account) }

      it 'redirects to spotify_playlists' do
        get accounts_login_url
        expect(response).to redirect_to(spotify_playlists_url)
      end
    end

    context 'when user is not logged in' do
      it 'returns http success' do
        get accounts_login_url
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /accounts/signup" do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies, account) }

      it 'redirects to spotify_playlists' do
        get accounts_signup_url
        expect(response).to redirect_to(spotify_playlists_url)
      end
    end

    context 'when user is not logged in' do
      it 'returns http success' do
        get accounts_signup_url
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /accounts/login' do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies, account) }

      it 'redirects to spotify_playlists' do
        post accounts_login_url
        expect(response).to redirect_to(spotify_playlists_url)
      end
    end

    context 'when user is not logged in' do
      context 'when account has a spotify user' do
        let!(:spotify_user) { create(:spotify_user, account:) }

        it 'redirects to spotify playlists view' do
          post accounts_login_url, params: { email: account.email, password: account.password }
          expect(response).to redirect_to(spotify_playlists_url)
        end
      end

      context 'when account does not have a spotify user' do
        it 'redirects to account_settings' do
          post accounts_login_url, params: { email: account.email, password: account.password }
          expect(response).to redirect_to(account_settings_url)
        end
      end
    end

    context 'when provided credentials are invalid' do
      it 'returns unauthorized' do
        post accounts_login_url, params: { email: account.email, password: "#{account.password}fakePW" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
